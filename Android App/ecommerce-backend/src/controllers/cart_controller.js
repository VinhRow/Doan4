const CartModel = require('./../models/cart_model');
//Cart Model để xử lý các yêu cầu trong giỏ hàng
const CartController = {
    //Lấy dữ liệu của giỏ hàng bằng Id người dùng
    getCartForUser: async function (req, res) {
        try {
            const user = req.params.user;
            const foundCart = await CartModel.findOne({ user: user }).populate("items.product");

            if (!foundCart) {
                return res.json({ success: true, data: [] });
            }

            return res.json({ success: true, data: foundCart.items });
        }
        catch (ex) {
            return res.json({ success: false, message: ex });
        }
    },
    // Thêm sản phẩm vào giỏ hàng
    addToCart: async function (req, res) {
        try {
            const { product, user, quantity } = req.body;
            const foundCart = await CartModel.findOne({ user: user });

            // If cart does not exist
            if (!foundCart) {
                const newCart = new CartModel({ user: user });
                newCart.items.push({
                    product: product,
                    quantity: quantity
                });

                await newCart.save();
                return res.json({ success: true, data: newCart, message: "Sản phẩm được thêm vào giỏ hàng" });
            }

            // Deleting the item if it already exists
            const deletedItem = await CartModel.findOneAndUpdate(
                { user: user, "items.product": product },
                { $pull: { items: { product: product } } },
                { new: true }
            );

            // If cart already exists
            const updatedCart = await CartModel.findOneAndUpdate(
                { user: user },
                { $push: { items: { product: product, quantity: quantity } } },
                { new: true }
            ).populate("items.product");
            return res.json({ success: true, data: updatedCart.items, message: "Sản phẩm được thêm vào giỏ hàng" });
        }
        catch (ex) {
            return res.json({ success: false, message: ex });
        }
    },
    // xóa sản phẩm khỏi giỏ hàng
    removeFromCart: async function (req, res) {
        try {
            const { user, product } = req.body;
            const updatedCart = await CartModel.findOneAndUpdate(
                { user: user },
                { $pull: { items: { product: product } } },
                { new: true }
            ).populate("items.product");

            return res.json({ success: true, data: updatedCart.items, message: "Sản phẩm được xóa khỏi giỏ hàng" });
        }
        catch (ex) {
            return res.json({ success: false, message: ex });
        }
    }

};

module.exports = CartController;