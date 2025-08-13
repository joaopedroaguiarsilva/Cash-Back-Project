// Onde vc coloca suas interfaces de banco de dados

namespace cap.cashback;

using { cuid, managed } from '@sap/cds/common';

    entity Orders : cuid, managed {
        key sales_order_id          : Integer;
        customer                    : Association to one Customers;
        applied_cashback            : Integer;
        amount                      : Integer;
        transactions                : Composition of many Orders.Transactions on transactions.order = $self;
    }

    entity Orders.Transactions : cuid {
        order                       : Association to one Orders;
        wallet                      : Association to one Wallets;
        type                        : String enum {
            CREDIT;
            REDEMPTION;
        };
        amount                      : Integer;
    }


    entity Wallets : cuid {
    balance                         : Integer default 0;
    customer                        : Association to one Customers;
    transactions                    : Association to many Orders.Transactions on transactions.wallet = $self;
    }

    entity Customers : cuid {
    wallets                         : Association to one Wallets on wallets.customer = $self;
    orders                          : Association to one Orders on orders.customer = $self;
    }


    entity Parameters {
        is_cashback_active          : Boolean;
        cashback_return             : Decimal;
        cashback_redemption_limit   : Decimal;
    }