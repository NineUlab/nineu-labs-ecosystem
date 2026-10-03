export type NodeRole = 'admin' | 'partner' | 'customer';

export interface UserProfile {
  id: string;
  email: string;
  fullName?: string;
  role: NodeRole;
  isActive: boolean;
}

export const appRoles: NodeRole[] = ['admin', 'partner', 'customer'];
