"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
require("module-alias/register");
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const dotenv_1 = __importDefault(require("dotenv"));
const mongoose_1 = __importDefault(require("mongoose"));
const auth_routes_1 = __importDefault(require("./routes/auth.routes"));
const item_routes_1 = __importDefault(require("./routes/item.routes"));
const chatRoutes_1 = __importDefault(require("./interfaces/routes/chatRoutes"));
// Load environment variables
dotenv_1.default.config();
const app = (0, express_1.default)();
// Middleware
app.use((0, cors_1.default)());
app.use(express_1.default.json());
// Database connection
mongoose_1.default.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/uni-lost-found')
    .then(() => console.log('Connected to MongoDB'))
    .catch((error) => console.error('MongoDB connection error:', error));
// Routes
app.use('/api', auth_routes_1.default);
app.use('/api', item_routes_1.default);
app.use('/api/chats', chatRoutes_1.default);
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
