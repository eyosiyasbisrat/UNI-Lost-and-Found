export interface Item {
  _id: string;
  name: string;
  description: string;
  location: string;
  imageUrl: string;
  foundDate: Date;
  foundTime: string;
  userId: string;
  status: 'lost' | 'found' | 'claimed';
} 