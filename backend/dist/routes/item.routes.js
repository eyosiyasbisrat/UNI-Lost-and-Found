"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const item_controller_1 = require("../controllers/item.controller");
const router = (0, express_1.Router)();
const itemController = new item_controller_1.ItemController();
// Get all items
router.get('/items', itemController.getAllItems);
// Add a found item
router.post('/items/found', itemController.addFoundItem);
// Add a lost item
router.post('/items/lost', itemController.addLostItem);
// Delete an item
router.delete('/items/:id', itemController.deleteItem);
exports.default = router;
