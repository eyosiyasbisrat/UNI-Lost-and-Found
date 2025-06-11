import { Router } from 'express';
import { ItemController } from '../controllers/item.controller';

const router = Router();
const itemController = new ItemController();

// Get all items
router.get('/items', itemController.getAllItems);

// Add a found item
router.post('/items/found', itemController.addFoundItem);

// Add a lost item
router.post('/items/lost', itemController.addLostItem);

// Delete an item
router.delete('/items/:id', itemController.deleteItem);

export default router; 