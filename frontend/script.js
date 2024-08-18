// Base URL of the API
const apiUrl = 'http://localhost:5000/';

// Function to fetch all products
function fetchProducts() {
    fetch(`${apiUrl}?action=getProducts`)
        .then(response => response.json())
        .then(data => {
            displayProducts(data);
        })
        .catch(error => console.error('Error fetching products:', error));
}

// Function to fetch details of a single product
function fetchProductDetails(productId) {
    fetch(`${apiUrl}?action=getProductDetails&id=${productId}`)
        .then(response => response.json())
        .then(data => {
            displayProductDetails(data);
        })
        .catch(error => console.error('Error fetching product details:', error));
}

// Function to add a product to the cart
function addToCart(productId) {
    fetch(`${apiUrl}?action=addToCart&id=${productId}`)
        .then(response => response.json())
        .then(data => {
            alert(data.message);
            updateCartDisplay(data.cart);
        })
        .catch(error => console.error('Error adding product to cart:', error));
}

// Function to fetch the current cart contents
function fetchCart() {
    fetch(`${apiUrl}?action=getCart`)
        .then(response => response.json())
        .then(data => {
            updateCartDisplay(data);
        })
        .catch(error => console.error('Error fetching cart:', error));
}

// Function to display products
function displayProducts(products) {
    const productGrid = document.querySelector('.product-grid');
    productGrid.innerHTML = products.map(product => `
        <div class="product-card">
            <img src="${product.image}" alt="${product.name}">
            <h3>${product.name}</h3>
            <p>$${Number(product.price).toFixed(2)}</p>
            <button class="btn add-to-cart-btn" data-id="${product.id}">Add to Cart</button>
        </div>
    `).join('');

    document.querySelectorAll('.add-to-cart-btn').forEach(button => {
        button.addEventListener('click', () => addToCart(button.dataset.id));
    });

    // Attach event listeners to the "Add to Cart" buttons
    document.querySelectorAll('.add-to-cart-btn').forEach(button => {
        button.addEventListener('click', () => {
            const productId = button.getAttribute('data-id');
            addToCart(productId);
        });
    });
}

// Function to display details of a single product
function displayProductDetails(product) {
    const productDetailsSection = document.querySelector('.product-details');
    productDetailsSection.innerHTML = `
        <img src="${product.image}" alt="${product.name}">
        <h3>${product.name}</h3>
        <p>$${product.price.toFixed(2)}</p>
        <p>${product.description}</p>
        <button class="btn add-to-cart-btn" data-id="${product.id}">Add to Cart</button>
    `;

    // Attach event listener to the "Add to Cart" button
    document.querySelector('.add-to-cart-btn').addEventListener('click', () => {
        addToCart(product.id);
    });
}

function updateCartDisplay(cart) {
    const cartItems = document.querySelector('.cart-items');
    cartItems.innerHTML = cart.length ? cart.map(item => `
        <div class="cart-item">
            <img src="${item.image}" alt="${item.name}">
            <h4>${item.name}</h4>
            <p>$${Number(item.price).toFixed(2)}</p>
            <p>Quantity: ${Number(1)}</p>
        </div>
    `).join('') : 'Your cart is empty.';
}



// Initialize the app by fetching and displaying the products
document.addEventListener('DOMContentLoaded', () => {
    fetchProducts();
    fetchCart(); // Optionally fetch and display the cart contents on page load
});

