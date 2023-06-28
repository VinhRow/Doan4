const ProductModel = require('./../models/product_model');
// Product Controller dùng để xử lý các yêu cầu của sản phẩm
const ProductController = {
    //Tạo sản phẩm mới
    createProduct: async function (req, res) {
        try {
            const productData = req.body;
            const newProduct = new ProductModel(productData);
            await newProduct.save();

            return res.json({ success: true, data: newProduct, message: "Sản phẩm đã được tạo!" });
        }
        catch (ex) {
            return res.json({ success: false, message: ex });
        }
    },
    //Lấy thông tin tất cả sáng phẩm
    fetchAllProducts: async function (req, res) {
        try {
            const products = await ProductModel.find();
            return res.json({ success: true, data: products });
        }
        catch (ex) {
            return res.json({ success: false, message: ex });
        }
    },
    //Lấy sản phẩm dựa trên id loại sản phẩm
    fetchProductByCategory: async function (req, res) {
        try {
            const categoryId = req.params.id;
            const products = await ProductModel.find({ category: categoryId });
            return res.json({ success: true, data: products });
        }
        catch (ex) {
            return res.json({ success: false, message: ex });
        }
    }

};

module.exports = ProductController;