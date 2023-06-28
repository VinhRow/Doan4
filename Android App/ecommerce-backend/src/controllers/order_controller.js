const OrderModel = require('./../models/order_model');
const CartModel = require('./../models/cart_model');
//Order Controller để xử lý các yêu cầu trong đơn hàng
const OrderController = {
    //tạo đơn hàng
    createOrder: async function (req, res) {
        try {
            const { user, items } = req.body;
            const newOrder = new OrderModel({
                user: user,
                items: items
            });
            await newOrder.save();

            // Update the cart
            await CartModel.findOneAndUpdate(
                { user: user._id },
                { items: [] }
            );

            return res.json({ success: true, data: newOrder, message: "Đã tạo đơn hàng!" });
        }
        catch (ex) {
            return res.json({ success: false, message: ex });
        }
    },
    //Lấy dữ liệu đơn hàng dựa trên user id
    fetchOrdersForUser: async function (req, res) {
        try {
            const userId = req.params.userId;
            const foundOrders = await OrderModel.find({
                "user._id": userId
            }).sort({ createdOn: -1 });
            return res.json({ success: true, data: foundOrders });
        }
        catch (ex) {
            return res.json({ success: false, message: ex });
        }
    },
    //Cập nhật trạng thái đơn hàng
    updateOrderStatus: async function (req, res) {
        try {
            const { orderId, status } = req.body;
            const updatedOrder = await OrderModel.findOneAndUpdate(
                { _id: orderId },
                { status: status },
                { new: true }
            );
            return res.json({ success: true, data: updatedOrder });
        }
        catch (ex) {
            return res.json({ success: false, message: ex });
        }
    }

};

module.exports = OrderController;