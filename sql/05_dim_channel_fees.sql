IF OBJECT_ID('dbo.dim_channel_fees', 'U') IS NOT NULL
    DROP TABLE dbo.dim_channel_fees ;


CREATE TABLE dbo.dim_channel_fees (
Channel_Fee_ID              INT IDENTITY(1,1) PRIMARY KEY,
Channel_Name                NVARCHAR(50),
Channel_Type                NVARCHAR(50),
Category_Name               NVARCHAR(250),
Commission_Pct              DECIMAL(5,4),
Fixed_Fee_USD               DECIMAL(10,2),
Shipping_Fee_USD            DECIMAL(10,2)
) ;

INSERT INTO dbo.dim_channel_fees (
    Channel_Name,
    Channel_Type,
    Category_Name,
    Commission_Pct,
    Fixed_Fee_USD,
    Shipping_Fee_USD
)
VALUES
    ('Allegro', 'Marketplace', 'Computers and electric accessories', 0.0700, 0.00, 1.50),
    ('Allegro', 'Marketplace', 'Electric household essentials',     0.0800, 0.00, 2.00),
    ('Allegro', 'Marketplace', 'Furniture',                         0.1100, 0.00, 0.00),
    ('Allegro', 'Marketplace', 'Butchers',                          0.1200, 0.00, 2.50),
    ('Allegro', 'Marketplace', 'Food',                              0.1200, 0.00, 1.20),
    ('Allegro', 'Marketplace', 'Beverages',                         0.1200, 0.00, 1.80),
    ('Allegro', 'Marketplace', 'Patisserie',                        0.1200, 0.00, 1.20),
    ('Allegro', 'Marketplace', 'Milk Products',                     0.1200, 0.00, 1.50),

    ('Amazon', 'Marketplace', 'Computers and electric accessories', 0.0800, 0.00, 3.20),
    ('Amazon', 'Marketplace', 'Electric household essentials',     0.0900, 0.00, 6.50),
    ('Amazon', 'Marketplace', 'Furniture',                         0.1500, 0.00, 24.00),
    ('Amazon', 'Marketplace', 'Butchers',                          0.1400, 0.00, 4.00),
    ('Amazon', 'Marketplace', 'Food',                              0.1400, 0.00, 3.50),
    ('Amazon', 'Marketplace', 'Beverages',                         0.1400, 0.00, 4.50),
    ('Amazon', 'Marketplace', 'Patisserie',                        0.1400, 0.00, 3.50),
    ('Amazon', 'Marketplace', 'Milk Products',                     0.1400, 0.00, 3.50),

    ('Own Store', 'Direct', 'Computers and electric accessories', 0.0150, 0.25, 0.00),
    ('Own Store', 'Direct', 'Electric household essentials',     0.0150, 0.25, 0.00),
    ('Own Store', 'Direct', 'Furniture',                         0.0150, 0.25, 0.00),
    ('Own Store', 'Direct', 'Butchers',                          0.0150, 0.25, 0.00),
    ('Own Store', 'Direct', 'Food',                              0.0150, 0.25, 0.00),
    ('Own Store', 'Direct', 'Beverages',                         0.0150, 0.25, 0.00),
    ('Own Store', 'Direct', 'Patisserie',                        0.0150, 0.25, 0.00),
    ('Own Store', 'Direct', 'Milk Products',                     0.0150, 0.25, 0.00),

    ('In-Store', 'Retail', 'Computers and electric accessories', 0.0050, 0.00, 0.00),
    ('In-Store', 'Retail', 'Electric household essentials',     0.0050, 0.00, 0.00),
    ('In-Store', 'Retail', 'Furniture',                         0.0050, 0.00, 0.00),
    ('In-Store', 'Retail', 'Butchers',                          0.0050, 0.00, 0.00),
    ('In-Store', 'Retail', 'Food',                              0.0050, 0.00, 0.00),
    ('In-Store', 'Retail', 'Beverages',                         0.0050, 0.00, 0.00),
    ('In-Store', 'Retail', 'Patisserie',                        0.0050, 0.00, 0.00),
    ('In-Store', 'Retail', 'Milk Products',                     0.0050, 0.00, 0.00);