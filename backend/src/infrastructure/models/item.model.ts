import mongoose, { Schema } from 'mongoose';
import { Item } from '../../domain/models/item.model';

const itemSchema = new Schema<Item>({
  name: { type: String, required: true },
  description: { type: String, required: true },
  location: { type: String, required: true },
  imageUrl: { type: String, required: true },
  foundDate: { type: Date, required: true },
  foundTime: { type: String, required: true },
  userId: { type: String, required: true },
  status: {
    type: String,
    enum: ['lost', 'found', 'claimed'],
    required: true,
  },
}, {
  timestamps: true,
});

export const ItemModel = mongoose.model<Item>('Item', itemSchema); 