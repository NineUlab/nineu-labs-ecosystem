export type Role = 'admin' | 'partner' | 'customer';

export type PlatformSettings = {
  defaultCurrency: string;
  supportedCurrencies: string[];
  maxActiveCompanyLeadsPerPartner: number;
  claimDurationMinutes: number;
};

export const platformDefaults: PlatformSettings = {
  defaultCurrency: 'USD',
  supportedCurrencies: ['USD', 'NGN', 'GBP'],
  maxActiveCompanyLeadsPerPartner: 2,
  claimDurationMinutes: 30
};
