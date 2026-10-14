let cart = [];
let currentPromo = null; // Lưu trữ promotion đang được áp dụng

// --- HỆ THỐNG THÔNG BÁO (TOAST) ---
function showToast(message, type = 'error') {
    let toast = document.getElementById('pos-toast');
    if (!toast) {
        toast = document.createElement('div');
        toast.id = 'pos-toast';
        toast.style.position = 'fixed';
        toast.style.bottom = '20px';
        toast.style.right = '20px';
        toast.style.padding = '15px 25px';
        toast.style.borderRadius = '8px';
        toast.style.color = '#fff';
        toast.style.fontWeight = 'bold';
        toast.style.zIndex = '9999';
        toast.style.boxShadow = '0 10px 20px rgba(0,0,0,0.3)';
        toast.style.transition = 'all 0.3s ease';
        document.body.appendChild(toast);
    }
    
    toast.style.background = type === 'error' ? '#ff4b2b' : '#38ada9';
    toast.innerText = message;
    toast.style.opacity = '1';
    toast.style.transform = 'translateY(0)';
    toast.style.pointerEvents = 'auto'; // Cho phép click khi đang hiện
    
    setTimeout(() => {
        toast.style.opacity = '0';
        toast.style.transform = 'translateY(20px)';
        toast.style.pointerEvents = 'none'; // Xuyên click khi đã ẩn
    }, 3000);
}

// 1. Thêm vào giỏ
function addToCart(id, name, price, stock) {
    if (stock <= 0) {
        showToast(`Sản phẩm "${name}" đã hết hàng!`, 'error');
        return;
    }

    const existing = cart.find(item => item.id === id);
    
    if (existing) {
        if (existing.quantity + 1 > stock) {
            showToast(`Sản phẩm "${name}" chỉ còn ${stock} trong kho!`, 'error');
            return;
        }
        existing.quantity += 1;
    } else {
        cart.push({ id, name, price, quantity: 1, stockLimit: stock });
    }
    renderCart();
    // showToast(`Đã thêm ${name}`, 'success'); // Optional success toast
}

// 2. Cập nhật giao diện giỏ hàng
function renderCart() {
    const body = document.getElementById('cart-body');
    if (!body) return;
    
    body.innerHTML = '';
    let subtotal = 0;

    cart.forEach((item, index) => {
        const itemTotal = item.price * item.quantity;
        subtotal += itemTotal;
        body.innerHTML += `
            <tr>
                <td>
                    <div style="font-weight: 600; font-size: 0.9rem;">${item.name}</div>
                    <div style="font-size: 0.75rem; color: var(--pos-text-muted);">${item.price.toLocaleString()}đ</div>
                </td>
                <td>
                    <input type="number" value="${item.quantity}" min="1" 
                           onchange="updateQty(${index}, this.value)" 
                           class="cart-qty-input">
                </td>
                <td style="text-align: right; font-weight: 700;">${itemTotal.toLocaleString()}đ</td>
                <td style="text-align: right;">
                    <i class="fas fa-times-circle" onclick="removeItem(${index})" 
                       style="color:#ff6b6b; cursor:pointer; font-size: 1.1rem;"></i>
                </td>
            </tr>
        `;
    });

    const itemsCountEl = document.getElementById('items-count');
    const subtotalEl = document.getElementById('subtotal');
    
    if (itemsCountEl) itemsCountEl.innerText = `${cart.length} mặt hàng`;
    if (subtotalEl) subtotalEl.innerText = subtotal.toLocaleString() + 'đ';
    
    recalculateDiscount(); // Tính lại discount nếu có mã Khuyến Mãi
}

function updateQty(index, val) {
    const newQty = parseInt(val) || 1;
    const item = cart[index];
    
    if (newQty > item.stockLimit) {
        showToast(`Sản phẩm "${item.name}" chỉ còn ${item.stockLimit} trong kho!`, 'error');
        item.quantity = item.stockLimit;
    } else if (newQty < 1) {
        item.quantity = 1;
    } else {
        item.quantity = newQty;
    }
    renderCart();
}

function removeItem(index) {
    cart.splice(index, 1);
    renderCart();
}

function updateTotal() {
    let subtotal = cart.reduce((s, i) => s + (i.price * i.quantity), 0);
    const discountEl = document.getElementById('discount');
    const finalTotalEl = document.getElementById('final-total');
    
    let discount = 0;
    if (discountEl) {
        discount = parseInt(discountEl.value) || 0;
    }
    
    let final = subtotal - discount;
    if (finalTotalEl) {
        finalTotalEl.innerText = (final > 0 ? final : 0).toLocaleString() + 'đ';
    }
}

// --- XỬ LÝ MÃ KHUYẾN MÃI TỰ ĐỘNG ---
let activePromotions = [];

async function loadActivePromotions() {
    try {
        const res = await fetch('/farmi-pos/app/api/khuyenmaiapi.php');
        const data = await res.json();
        if (data.status === 'success') {
            const today = new Date().toISOString().split('T')[0];
            // Chỉ lấy các promotion đang trong thời gian hiệu lực
            activePromotions = data.data.filter(p => p.ngay_bat_dau <= today && p.ngay_ket_thuc >= today);
            
            // Sau khi load xong thì hiển thị badge lên UI
            applyPromotionsToUI();
        }
    } catch (e) {
        console.error("Lỗi tải khuyến mãi tự động:", e);
    }
}

function applyPromotionsToUI() {
    if (activePromotions.length === 0) return;

    activePromotions.forEach(promo => {
        const phanTram = promo.phan_tram_giam;
        const ids = promo.danh_sach_san_pham ? promo.danh_sach_san_pham.split(',').map(id => id.trim()) : [];
        
        ids.forEach(id => {
            const card = document.getElementById('product-card-' + id);
            if (card) {
                // Kiểm tra xem đã có badge chưa để tránh lặp
                if (!card.querySelector('.promo-badge')) {
                    const badge = document.createElement('div');
                    badge.className = 'promo-badge';
                    badge.innerHTML = `<i class="fas fa-tag"></i> Giảm ${phanTram}%`;
                    card.style.position = 'relative'; // Đảm bảo card có position relative
                    card.appendChild(badge);
                }
            }
        });
    });
}

function recalculateDiscount() {
    let discountAmount = 0;
    const msgEl = document.getElementById('promo-msg');
    let autoPromoMessages = [];

    // 1. Giảm từ KH
    let pointDiscount = 0;
    const pointsInput = document.getElementById('points-to-use');
    if (pointsInput && parseInt(pointsInput.value)) {
        pointDiscount = parseInt(pointsInput.value) * 1000;
    }

    // 2. Tự động kiểm tra và Giảm từ Khuyến Mãi
    let promoDiscount = 0;
    let productsDiscounted = new Set();
    
    if (activePromotions.length > 0) {
        cart.forEach(item => {
            // Xem sản phẩm có thuộc bất kỳ chương trình nào không
            for (let promo of activePromotions) {
                const phanTram = parseFloat(promo.phan_tram_giam) || 0;
                const validIds = promo.danh_sach_san_pham ? promo.danh_sach_san_pham.split(',').map(id => id.trim()) : [];
                
                if (validIds.includes(item.id.toString())) {
                    promoDiscount += (item.price * item.quantity * (phanTram / 100));
                    productsDiscounted.add(promo.ma_code); 
                    break; // Chỉ cần áp dụng 1 KM đầu tiên tìm thấy cho sản phẩm này
                }
            }
        });
    }

    if (productsDiscounted.size > 0) {
        autoPromoMessages.push(`Tự động áp dụng mã: ${Array.from(productsDiscounted).join(', ')}`);
    }

    discountAmount = Math.round(pointDiscount + promoDiscount);
    
    // Cập nhật giao diện
    const discountEl = document.getElementById('discount');
    if (discountEl) {
        discountEl.value = discountAmount;
    }
    
    if (msgEl) {
        msgEl.innerText = autoPromoMessages.join(' | ');
    }
    
    updateTotal();
}

// 3. Lọc sản phẩm theo tên
function filterProducts() {
    let input = document.getElementById('search-product').value.toLowerCase();
    let cards = document.getElementsByClassName('product-card');
    
    for (let card of cards) {
        let name = card.querySelector('.p-name').innerText.toLowerCase();
        card.style.display = name.includes(input) ? "flex" : "none";
    }
}

// 4. Lọc sản phẩm theo danh mục
function filterCategory(category) {
    // Cập nhật trạng thái nút Active
    const buttons = document.querySelectorAll('.btn-cat');
    buttons.forEach(btn => {
        if (btn.innerText.trim() === category || (category === 'all' && btn.innerText.trim() === 'Tất cả')) {
            btn.classList.add('active');
        } else {
            btn.classList.remove('active');
        }
    });

    // Lọc các card
    const cards = document.querySelectorAll('.product-card');
    cards.forEach(card => {
        const cardCat = card.getAttribute('data-category');
        if (category === 'all' || cardCat === category) {
            card.style.display = 'flex';
        } else {
            card.style.display = 'none';
        }
    });
}

// --- QUẢN LÝ KHÁCH HÀNG ---
let allCustomers = [];
let selectedCustomerId = null;
let selectedCustomerPoints = 0;

async function loadCustomers() {
    try {
        const response = await fetch('/farmi-pos/app/api/customerapi.php');
        const result = await response.json();
        if (result.status === 'success') {
            allCustomers = result.data;
        }
    } catch (e) { console.error("Lỗi tải khách hàng:", e); }
}

function searchCustomer() {
    const input = document.getElementById('customer-search').value.toLowerCase().trim();
    const resultsDiv = document.getElementById('customer-results');
    
    if (input.length < 1) {
        resultsDiv.style.display = 'none';
        return;
    }

    const matches = allCustomers.filter(c => 
        c.ho_ten.toLowerCase().includes(input) || 
        c.so_dien_thoai.includes(input)
    ).slice(0, 5); // Hiện tối đa 5 kết quả

    if (matches.length > 0) {
        resultsDiv.innerHTML = matches.map(c => `
            <div class="search-item" onclick="selectCustomer(${c.id}, '${c.ho_ten}', ${c.diem_tich_luy})">
                <div style="font-weight:600;">${c.ho_ten}</div>
                <div style="font-size:0.75rem; color:#A3BFB0;">${c.so_dien_thoai} - Điểm: ${c.diem_tich_luy}</div>
            </div>
        `).join('');
        resultsDiv.style.display = 'block';
    } else {
        resultsDiv.innerHTML = '<div class="search-item" style="color:#ff6b6b; cursor:default;">Không tìm thấy khách này...</div>';
        resultsDiv.style.display = 'block';
    }
}

function selectCustomer(id, name, points) {
    selectedCustomerId = id;
    selectedCustomerPoints = points; // Cần khai báo biến này ở đầu file hoặc lưu trữ
    document.getElementById('customer-search').value = "";
    document.getElementById('customer-results').style.display = 'none';
    
    // Hiển thị thông tin khách đã chọn
    document.querySelector('.customer-search-box').style.display = 'none';
    const infoBox = document.getElementById('selected-customer-info');
    infoBox.style.display = 'flex';
    document.getElementById('display-cust-name').innerText = name;
    document.getElementById('display-cust-points').innerText = points;
    
    // Reset points input
    const pointsInput = document.getElementById('points-to-use');
    if (pointsInput) pointsInput.value = '';
}

function applyPoints() {
    const pointsInput = document.getElementById('points-to-use');
    const discountEl = document.getElementById('discount');
    if (!pointsInput || !discountEl) return;

    let points = parseInt(pointsInput.value) || 0;
    
    // Kiểm tra không dùng quá số điểm đang có
    if (points > selectedCustomerPoints) {
        alert("Khách hàng chỉ có " + selectedCustomerPoints + " điểm!");
        points = selectedCustomerPoints;
        pointsInput.value = points;
    }

    if (points < 0) {
        points = 0;
        pointsInput.value = 0;
    }

    // Quy đổi: 1 điểm = 1000đ
    // Cập nhật ô GIẢM GIÁ thông qua hàm tổng hợp
    recalculateDiscount();
}

function clearCustomer() {
    selectedCustomerId = null;
    selectedCustomerPoints = 0;
    document.querySelector('.customer-search-box').style.display = 'flex';
    document.getElementById('selected-customer-info').style.display = 'none';
    document.getElementById('customer-search').focus();
    
    // Reset discount nếu đang dùng điểm
    const pointsInput = document.getElementById('points-to-use');
    if (pointsInput) pointsInput.value = '';
    recalculateDiscount();
}

// Thêm khách hàng mới nhanh
function openNewCustModal() {
    document.getElementById('newCustModal').style.display = 'flex';
    document.getElementById('new-cust-name').focus();
}

function closeNewCustModal() {
    document.getElementById('newCustModal').style.display = 'none';
    document.getElementById('new-cust-name').value = '';
    document.getElementById('new-cust-phone').value = '';
}

async function saveNewCustomer() {
    const name = document.getElementById('new-cust-name').value.trim();
    const phone = document.getElementById('new-cust-phone').value.trim();

    if (!name || !phone) {
        alert("Vui lòng nhập đủ Tên và Số điện thoại!");
        return;
    }

    try {
        const response = await fetch('/farmi-pos/app/api/customerapi.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ ho_ten: name, so_dien_thoai: phone })
        });
        const result = await response.json();

        if (result.status === 'success') {
            await loadCustomers(); // Tải lại danh sách
            // Tìm khách mới tạo để lấy ID
            const newCust = allCustomers.find(c => c.so_dien_thoai === phone);
            if (newCust) {
                selectCustomer(newCust.id, newCust.ho_ten, 0);
            }
            closeNewCustModal();
        } else {
            alert("Lỗi: " + result.message);
        }
    } catch (e) {
        alert("Lỗi kết nối máy chủ!");
    }
}

// Gọi load khách hàng và khuyến mãi khi bắt đầu
document.addEventListener('DOMContentLoaded', () => {
    loadCustomers();
    loadActivePromotions();
});

// --- PHẦN POS LOGIC CŨ ---

// 5. Xử lý thanh toán
async function processPayment(e) {
    if (e && e.preventDefault) e.preventDefault();
    
    if (cart.length === 0) {
        showToast("Giỏ hàng đang trống!", 'error');
        return;
    }
    
    // Tính toán trực tiếp từ mảng cart
    const subtotal = cart.reduce((s, i) => s + (i.price * i.quantity), 0);
    const discountEl = document.getElementById('discount');
    const discount = parseInt(discountEl ? discountEl.value : 0) || 0;
    const finalTotal = subtotal - discount;
    
    // Lấy phương thức thanh toán
    const activePayBtn = document.querySelector('.btn-pay.active');
    const paymentMethod = activePayBtn && activePayBtn.querySelector('span') ? activePayBtn.querySelector('span').innerText : 'Tiền mặt';

    if (confirm(`Xác nhận thanh toán đơn hàng: ${finalTotal.toLocaleString()}đ?`)) {
        try {
            const payload = {
                cart: cart,
                subtotal: subtotal,
                discount: discount,
                total: finalTotal,
                payment_method: paymentMethod,
                customer_id: selectedCustomerId,
                points_to_use: parseInt(document.getElementById('points-to-use')?.value || 0)
            };

            const response = await fetch('/farmi-pos/app/api/orderapi.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            });

            const result = await response.json();

            if (result.status === 'success') {
                showToast("Thanh toán thành công! Mã đơn: #" + result.order_id, 'success');
                
                // Cập nhật tồn kho hiển thị ngay lập tức
                cart.forEach(item => {
                    const card = document.getElementById('product-card-' + item.id);
                    if (card) {
                        item.stockLimit -= item.quantity;
                        const stockValEl = card.querySelector('.stock-qty-val');
                        if (stockValEl) stockValEl.innerText = item.stockLimit;

                        // Cập nhật thuộc tính onclick để lần sau lấy đúng stock mới
                        card.setAttribute('onclick', `addToCart(${item.id}, '${item.name.replace(/'/g, "\\'")}', ${item.price}, ${item.stockLimit})`);

                        if (item.stockLimit <= 0) {
                            card.classList.add('out-of-stock');
                            card.style.opacity = '0.4';
                            card.style.filter = 'grayscale(1)';
                            card.style.pointerEvents = 'none';
                        }
                    }
                });

                // Reset giỏ hàng
                cart = [];
                renderCart();
                
                if (discountEl) discountEl.value = 0;
                const promoMsg = document.getElementById('promo-msg');
                if (promoMsg) promoMsg.innerText = '';

                clearCustomer();
                loadCustomers(); // Load lại điểm của khách hàng
            } else {
                showToast("Lỗi: " + result.message);
            }
        } catch (error) {
            console.error("Payment Error:", error);
            showToast("Có lỗi xảy ra khi kết nối máy chủ!");
        }
    }
}

// Hỗ trợ phím tắt
document.addEventListener('keydown', function(e) {
    if (e.key === 'F10') {
        e.preventDefault();
        processPayment();
    }
});

// --- CHỨC NĂNG VIETQR ---
function showVietQR() {
    if (cart.length === 0) {
        showToast("Vui lòng thêm sản phẩm vào giỏ hàng trước!", 'error');
        // Trả lại trạng thái Tiền mặt nếu giỏ trống
        const cashBtn = document.querySelector('.btn-pay:first-child');
        if (cashBtn) {
            document.querySelectorAll('.btn-pay').forEach(b => b.classList.remove('active'));
            cashBtn.classList.add('active');
        }
        return;
    }

    const subtotal = cart.reduce((s, i) => s + (i.price * i.quantity), 0);
    const discount = parseInt(document.getElementById('discount')?.value || 0) || 0;
    const finalTotal = subtotal - discount;
    const amount = finalTotal > 0 ? finalTotal : 0;

    // Cập nhật hiển thị số tiền
    document.getElementById('qr-amount').innerText = amount.toLocaleString() + 'đ';
    
    // Tạo link VietQR (VCB - 9339670825 - Template compact2)
    const bankId = "VCB";
    const accountNo = "9339670825";
    const template = "compact2";
    const description = encodeURIComponent("ThanhToanPOS");
    const accountName = encodeURIComponent("LE XUAN THANG");
    
    const qrUrl = `https://img.vietqr.io/image/${bankId}-${accountNo}-${template}.png?amount=${amount}&addInfo=${description}&accountName=${accountName}`;
    
    const qrImg = document.getElementById('qr-image');
    if (qrImg) {
        qrImg.src = qrUrl;
    }
    
    const modal = document.getElementById('vietqr-modal');
    if (modal) {
        modal.style.display = 'flex';
    }
}

function closeVietQR() {
    const modal = document.getElementById('vietqr-modal');
    if (modal) {
        modal.style.display = 'none';
    }
}