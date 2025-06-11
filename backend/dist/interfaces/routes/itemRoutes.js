"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const ItemController_1 = require("../controllers/ItemController");
const auth_1 = require("../middleware/auth");
const ItemRepository_1 = require("@domain/repositories/ItemRepository");
const router = (0, express_1.Router)();
const itemController = new ItemController_1.ItemController();
const itemRepository = new ItemRepository_1.ItemRepository();
// Public routes
router.get("/", itemController.getAllItems.bind(itemController));
router.get("/recent", itemController.getRecentItems.bind(itemController));
router.get("/today", itemController.getTodayItems.bind(itemController));
router.get("/:id", itemController.getItemById.bind(itemController));
// Protected routes
router.post("/", (req, res, next) => itemController.createItem(req, res, next));
router.get("/found", (req, res, next) => itemController.getItemsByFoundBy(req, res, next));
router.get("/claimed", (req, res, next) => itemController.getItemsByClaimedBy(req, res, next));
router.put("/:id", (req, res, next) => itemController.updateItem(req, res, next));
router.delete("/:id", (req, res, next) => itemController.deleteItem(req, res, next));
router.post("/:id/claim", (req, res, next) => itemController.claimItem(req, res, next));
router.post("/:id/return", (req, res, next) => itemController.markAsReturned(req, res, next));
// Admin routes
router.delete("/admin/items/:id", auth_1.authenticateToken, auth_1.requireAdmin, async (req, res) => {
    const itemId = req.params.id;
    try {
        const deleted = await itemRepository.delete(itemId);
        if (deleted) {
            res.json({ message: "Item deleted successfully" });
        }
        else {
            res.status(404).json({ message: "Item not found" });
        }
    }
    catch (error) {
        res.status(500).json({ message: "Failed to delete item" });
    }
});
router.get("/admin/items", auth_1.authenticateToken, auth_1.requireAdmin, async (req, res) => {
    try {
        const items = await itemRepository.findAll();
        res.json(items);
    }
    catch (error) {
        res.status(500).json({ message: "Failed to fetch items" });
    }
});
// Admin: update any item
router.put("/admin/items/:id", auth_1.authenticateToken, auth_1.requireAdmin, async (req, res) => {
    const itemId = req.params.id;
    try {
        const updatedItem = await itemRepository.update(itemId, req.body);
        if (updatedItem) {
            res.json({ message: "Item updated", item: updatedItem });
        }
        else {
            res.status(404).json({ message: "Item not found" });
        }
    }
    catch (error) {
        res.status(500).json({ message: "Failed to update item" });
    }
});
exports.default = router;
