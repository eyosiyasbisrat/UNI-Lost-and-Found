"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ItemController = void 0;
const ItemService_1 = require("@domain/services/ItemService");
const mongoose_1 = __importDefault(require("mongoose"));
class ItemController {
    constructor() {
        this.itemService = new ItemService_1.ItemService();
    }
    async createItem(req, res, next) {
        try {
            //   if (!req.user) {
            //     return res.status(401).json({ message: "User not authenticated" });
            //   }
            const itemData = {
                ...req.body,
                foundBy: new mongoose_1.default.Types.ObjectId("682227ec446143734e3a3ed4"),
            };
            const item = await this.itemService.createItem(itemData);
            res.status(201).json(item);
        }
        catch (error) {
            console.log(error);
            res.status(500).json({ message: "Error creating item" });
        }
    }
    async getAllItems(req, res, next) {
        try {
            const items = await this.itemService.getAllItems();
            res.json(items);
        }
        catch (error) {
            res
                .status(500)
                .json({ message: (error === null || error === void 0 ? void 0 : error.message) || "Failed to fetch items" });
        }
    }
    async getItemById(req, res, next) {
        try {
            const item = await this.itemService.getItemById(req.params.id);
            if (!item) {
                return res.status(404).json({ message: "Item not found" });
            }
            res.json(item);
        }
        catch (error) {
            res
                .status(500)
                .json({ message: (error === null || error === void 0 ? void 0 : error.message) || "Failed to fetch item" });
        }
    }
    async getItemsByFoundBy(req, res, next) {
        try {
            if (!req.user) {
                return res.status(401).json({ message: "User not authenticated" });
            }
            const items = await this.itemService.getItemsByFoundBy(req.user._id.toString());
            res.json(items);
        }
        catch (error) {
            res.status(500).json({ message: "Error fetching items" });
        }
    }
    async getItemsByClaimedBy(req, res, next) {
        try {
            if (!req.user) {
                return res.status(401).json({ message: "User not authenticated" });
            }
            const items = await this.itemService.getItemsByClaimedBy(req.user._id.toString());
            res.json(items);
        }
        catch (error) {
            res.status(500).json({ message: "Error fetching items" });
        }
    }
    async updateItem(req, res, next) {
        try {
            const item = await this.itemService.updateItem(req.params.id, req.body);
            if (!item) {
                return res.status(404).json({ message: "Item not found" });
            }
            res.json(item);
        }
        catch (error) {
            res
                .status(400)
                .json({ message: (error === null || error === void 0 ? void 0 : error.message) || "Failed to update item" });
        }
    }
    async deleteItem(req, res, next) {
        try {
            const item = await this.itemService.getItemById(req.params.id);
            if (!item) {
                return res.status(404).json({ message: "Item not found" });
            }
            // Allow if user is owner or admin
            if (req.user &&
                (req.user._id.equals(item.foundBy) || req.user.role === "admin")) {
                await this.itemService.deleteItem(req.params.id);
                return res.json({ message: "Item deleted successfully" });
            }
            return res
                .status(403)
                .json({ message: "Not authorized to delete this item" });
        }
        catch (error) {
            res
                .status(500)
                .json({ message: (error === null || error === void 0 ? void 0 : error.message) || "Failed to delete item" });
        }
    }
    async getRecentItems(req, res, next) {
        try {
            const days = parseInt(req.query.days) || 7;
            const items = await this.itemService.getRecentItems(days);
            res.json(items);
        }
        catch (error) {
            res
                .status(500)
                .json({ message: (error === null || error === void 0 ? void 0 : error.message) || "Failed to fetch recent items" });
        }
    }
    async getTodayItems(req, res, next) {
        try {
            const items = await this.itemService.getTodayItems();
            res.json(items);
        }
        catch (error) {
            res
                .status(500)
                .json({ message: (error === null || error === void 0 ? void 0 : error.message) || "Failed to fetch today's items" });
        }
    }
    async claimItem(req, res, next) {
        try {
            if (!req.user) {
                return res.status(401).json({ message: "User not authenticated" });
            }
            const item = await this.itemService.claimItem(req.params.id, req.user._id.toString());
            if (!item) {
                return res.status(404).json({ message: "Item not found" });
            }
            res.json(item);
        }
        catch (error) {
            res.status(500).json({ message: "Error claiming item" });
        }
    }
    async markAsReturned(req, res, next) {
        try {
            const item = await this.itemService.markAsReturned(req.params.id);
            if (!item) {
                return res.status(404).json({ message: "Item not found" });
            }
            res.json(item);
        }
        catch (error) {
            res
                .status(400)
                .json({ message: (error === null || error === void 0 ? void 0 : error.message) || "Failed to mark item as returned" });
        }
    }
}
exports.ItemController = ItemController;
