const UserModel = require('./../models/user_model');
const bcrypt = require('bcrypt');
//User Controller để xử lý các yêu cầu của người dùng
const UserController = {
    //tạo tài khoản mới
    createAccount: async function (req, res) {
        try {
            const userData = req.body;
            const newUser = new UserModel(userData);
            await newUser.save();

            return res.json({ success: true, data: newUser, message: "Tài khoản đã được tạo!" });
        }
        catch (ex) {
            return res.json({ success: false, message: ex });
        }
    },
    //Đăng nhập
    signIn: async function (req, res) {
        try {
            const { email, password } = req.body;

            const foundUser = await UserModel.findOne({ email: email });
            if (!foundUser) {
                return res.json({ success: false, message: "Không tìm thấy tài khoản!" });
            }

            const passwordsMatch = bcrypt.compareSync(password, foundUser.password);
            if (!passwordsMatch) {
                return res.json({ success: false, message: "Mật khẩu không chính xác!" });
            }

            return res.json({ success: true, data: foundUser });
        }
        catch (ex) {
            return res.json({ success: false, message: ex });
        }
    },
    //Cập nhật thông tin người dùng
    updateUser: async function (req, res) {
        try {
            const userId = req.params.id;
            const updateData = req.body;

            const updatedUser = await UserModel.findOneAndUpdate(
                { _id: userId },
                updateData,
                { new: true }
            );

            if (!updatedUser) {
                throw "Không tìm thấy tài khoản!";
            }

            return res.json({ success: true, data: updatedUser, message: "Tài khoàn đã được cập nhật!" });
        }
        catch (ex) {
            return res.json({ success: false, message: ex });
        }
    }

};

module.exports = UserController;