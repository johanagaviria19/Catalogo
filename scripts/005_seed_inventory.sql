-- =============================================
-- SCRIPT DE INSERCIÓN DE INVENTARIO AS DE NARIÑO
-- =============================================

-- Primero insertamos las categorías
INSERT INTO categories (name, description) VALUES
('Bolsas Plásticas', 'Bolsas de diferentes tamaños y tipos'),
('Bolsas Cierre Hermético', 'Bolsas con cierre hermético tipo ziploc'),
('Bolsas de Papel', 'Bolsas de papel para diferentes usos'),
('Bolsas de Aluminio', 'Bolsas de aluminio para alimentos'),
('Bolsas de Basura', 'Bolsas para basura y residuos'),
('Contenedores', 'Contenedores y portacomidas'),
('Vasos Desechables', 'Vasos de diferentes materiales y tamaños'),
('Vasos de Cartón', 'Vasos de cartón biodegradables'),
('Platos Desechables', 'Platos espumados y biodegradables'),
('Cubiertos Desechables', 'Cucharas, tenedores y cuchillos'),
('Copas y Salseras', 'Copas para salsas y bebidas'),
('Servilletas', 'Servilletas de diferentes tipos'),
('Toallas', 'Toallas de cocina y de manos'),
('Papel Aluminio y Vinipel', 'Papel aluminio y plástico para envolver'),
('Papel Higiénico', 'Papel higiénico y tissue'),
('Limpieza General', 'Productos de limpieza multiusos'),
('Detergentes', 'Detergentes y jabones'),
('Escobas y Traperos', 'Escobas, traperos y accesorios'),
('Esponjas y Fibras', 'Esponjas y fibras para limpieza'),
('Desinfectantes', 'Blanqueadores y desinfectantes'),
('Ambientadores', 'Ambientadores y aromatizantes'),
('Guantes', 'Guantes de manipulación y limpieza'),
('Tapabocas y Gorros', 'Elementos de protección personal'),
('Palillos y Mezcladores', 'Palillos, brochetas y mezcladores'),
('Tapas', 'Tapas para vasos y contenedores'),
('Cuidado Personal', 'Shampoo, jabones y cremas'),
('Bandejas y Moldes', 'Bandejas y moldes de aluminio'),
('Accesorios de Limpieza', 'Cepillos, recogedor y otros')
ON CONFLICT (name) DO NOTHING;

-- Ahora insertamos los productos
-- Categoría: Bolsas Plásticas
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('BOLSA T-15 BLANCA', 'Bolsa plástica T-15 color blanca', 5000, 45, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA T-19', 'Bolsa plástica T-19', 5000, 70, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA T-20', 'Bolsa plástica T-20', 5500, 23, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA T-25', 'Bolsa plástica T-25', 6000, 54, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA T-30', 'Bolsa plástica T-30', 7000, 21, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA T-40', 'Bolsa plástica T-40', 8000, 48, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA T-50', 'Bolsa plástica T-50', 9000, 6, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA MANIGUETA T-25 RAYA AZUL', 'Bolsa con manigueta T-25 raya azul', 7000, 10, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA MANIGUETA T-25 RAYA ROSADA', 'Bolsa con manigueta T-25 raya rosada', 7000, 8, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA MANIGUETA VT-30 RAYA', 'Bolsa con manigueta VT-30 con rayas', 8000, 9, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA MATRIMONIO LECHOSA', 'Bolsa matrimonio lechosa', 6000, 3, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA MATRIMONIO TRANSPARENTE', 'Bolsa matrimonio transparente', 6000, 304, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA CINTA NAVIDEÑA', 'Bolsa con cinta navideña', 5000, 100, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA COLOR 6X8 (LIBRA)', 'Bolsa de color 6x8 por libra', 4000, 92, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA COLOR 7X10 (KILO)', 'Bolsa de color 7x10 por kilo', 5000, 51, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('Bolsa Pequeña Estampada', 'Bolsa pequeña con estampado', 3000, 238, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA TRANSPARENTE 2 KILOS', 'Bolsa transparente 2 kilos', 4500, 26, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA TRANSPARENTE 2X8', 'Bolsa transparente 2x8', 3000, 14, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA TRANSPARENTE 3 KILOS (9X14)', 'Bolsa transparente 3 kilos', 5000, 13, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA TRANSPARENTE 3X10', 'Bolsa transparente 3x10', 3000, 25, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA TRANSPARENTE 4X6', 'Bolsa transparente 4x6', 3000, 27, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA TRANSPARENTE 7X10', 'Bolsa transparente 7x10', 3500, 3, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA TRANSPARENTE KILO', 'Bolsa transparente por kilo', 4000, 34, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('Bolsa Transparente Libra (5x9)', 'Bolsa transparente libra 5x9', 3500, 24, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('Bolsa Trans 2 kilos Calibre 1', 'Bolsa transparente 2 kilos calibre 1', 4500, 30, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA POLIPROPILENO 10 X 16', 'Bolsa polipropileno 10x16', 5000, 2, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas')),
('BOLSA POLIPROPILENO 9 X 14', 'Bolsa polipropileno 9x14', 4500, 2, true, (SELECT id FROM categories WHERE name = 'Bolsas Plásticas'))
ON CONFLICT DO NOTHING;

-- Categoría: Bolsas Cierre Hermético
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('BOLSA CIERRE HERMETICO 10X14 PQ X 100', 'Bolsa cierre hermético 10x14 paq x 100', 8000, 5, true, (SELECT id FROM categories WHERE name = 'Bolsas Cierre Hermético')),
('BOLSA CIERRE HERMETICO 15X20 PQ X 100', 'Bolsa cierre hermético 15x20 paq x 100', 10000, 5, true, (SELECT id FROM categories WHERE name = 'Bolsas Cierre Hermético')),
('BOLSA CIERRE HERMETICO 2.5X2.5 PQ X 100', 'Bolsa cierre hermético 2.5x2.5 paq x 100', 4000, 26, true, (SELECT id FROM categories WHERE name = 'Bolsas Cierre Hermético')),
('BOLSA CIERRE HERMETICO 3.5X3 PQ X 100', 'Bolsa cierre hermético 3.5x3 paq x 100', 4500, 20, true, (SELECT id FROM categories WHERE name = 'Bolsas Cierre Hermético')),
('BOLSA CIERRE HERMETICO 30X20 PQ X 100', 'Bolsa cierre hermético 30x20 paq x 100', 12000, 7, true, (SELECT id FROM categories WHERE name = 'Bolsas Cierre Hermético')),
('BOLSA CIERRE HERMETICO 40X30 PQ X 100', 'Bolsa cierre hermético 40x30 paq x 100', 15000, 8, true, (SELECT id FROM categories WHERE name = 'Bolsas Cierre Hermético')),
('BOLSA CIERRE HERMETICO 5X5 PQ X 100', 'Bolsa cierre hermético 5x5 paq x 100', 5000, 16, true, (SELECT id FROM categories WHERE name = 'Bolsas Cierre Hermético')),
('BOLSA CIERRE HERMETICO 6X5 PQ X 100', 'Bolsa cierre hermético 6x5 paq x 100', 5500, 7, true, (SELECT id FROM categories WHERE name = 'Bolsas Cierre Hermético')),
('BOLSA CIERRE HERMETICO 6X9 PQ X 100', 'Bolsa cierre hermético 6x9 paq x 100', 6000, 7, true, (SELECT id FROM categories WHERE name = 'Bolsas Cierre Hermético')),
('BOLSA CIERRE HERMETICO 8X18', 'Bolsa cierre hermético 8x18', 7000, 10, true, (SELECT id FROM categories WHERE name = 'Bolsas Cierre Hermético')),
('BOLSA CIERRE HERMETICO 9X5 PQ X 100', 'Bolsa cierre hermético 9x5 paq x 100', 5500, 4, true, (SELECT id FROM categories WHERE name = 'Bolsas Cierre Hermético'))
ON CONFLICT DO NOTHING;

-- Categoría: Bolsas de Papel
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('BOLSA PAPEL 1/2 LIBRA', 'Bolsa de papel media libra', 3000, 3, true, (SELECT id FROM categories WHERE name = 'Bolsas de Papel')),
('BOLSA PAPEL 1/4 LIBRA BLANCA', 'Bolsa de papel 1/4 libra blanca', 2500, 3, true, (SELECT id FROM categories WHERE name = 'Bolsas de Papel')),
('Bolsa Papel 1/4 de Libra', 'Bolsa de papel 1/4 de libra', 2500, 22, true, (SELECT id FROM categories WHERE name = 'Bolsas de Papel')),
('BOLSA PAPEL 3 libras', 'Bolsa de papel 3 libras', 4000, 29, true, (SELECT id FROM categories WHERE name = 'Bolsas de Papel')),
('Bolsa Papel 4 libras', 'Bolsa de papel 4 libras', 4500, 14, true, (SELECT id FROM categories WHERE name = 'Bolsas de Papel')),
('Bolsa papel 2 libras', 'Bolsa de papel 2 libras', 3500, 26, true, (SELECT id FROM categories WHERE name = 'Bolsas de Papel')),
('Bolsa papel 6 libras', 'Bolsa de papel 6 libras', 5000, 19, true, (SELECT id FROM categories WHERE name = 'Bolsas de Papel')),
('Bolsa Papel Libra', 'Bolsa de papel libra', 3000, 13, true, (SELECT id FROM categories WHERE name = 'Bolsas de Papel')),
('Bolsa Papel Domicilios # 20 paq x 100', 'Bolsa papel domicilios #20 paq x 100', 12000, 10, true, (SELECT id FROM categories WHERE name = 'Bolsas de Papel')),
('Bolsa Papel Domicilios # 60 paq. x 50', 'Bolsa papel domicilios #60 paq x 50', 15000, 5, true, (SELECT id FROM categories WHERE name = 'Bolsas de Papel')),
('Bosa Papel para Cubiertos', 'Bolsa de papel para cubiertos', 2000, 203, true, (SELECT id FROM categories WHERE name = 'Bolsas de Papel'))
ON CONFLICT DO NOTHING;

-- Categoría: Bolsas de Aluminio
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('Bolsa de Aluminio L-17', 'Bolsa de aluminio L-17', 6000, 213, true, (SELECT id FROM categories WHERE name = 'Bolsas de Aluminio')),
('Bolsa de Aluminio L-19', 'Bolsa de aluminio L-19', 7000, 99, true, (SELECT id FROM categories WHERE name = 'Bolsas de Aluminio')),
('Bolsa de Aluminio L-21', 'Bolsa de aluminio L-21', 8000, 54, true, (SELECT id FROM categories WHERE name = 'Bolsas de Aluminio')),
('Bolsa Aluminio L-23', 'Bolsa de aluminio L-23', 9000, 6, true, (SELECT id FROM categories WHERE name = 'Bolsas de Aluminio')),
('Bolsa Aluminio L-25', 'Bolsa de aluminio L-25', 10000, 60, true, (SELECT id FROM categories WHERE name = 'Bolsas de Aluminio')),
('Bolsa Aluminio Pizza P', 'Bolsa de aluminio para pizza pequeña', 8000, 9, true, (SELECT id FROM categories WHERE name = 'Bolsas de Aluminio'))
ON CONFLICT DO NOTHING;

-- Categoría: Bolsas de Basura
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('Bolsa Basura Negra 55x70x10 Rollo', 'Bolsa basura negra 55x70x10 rollo', 8000, 8, true, (SELECT id FROM categories WHERE name = 'Bolsas de Basura')),
('Bolsa Basura Verde 55x70x10', 'Bolsa basura verde 55x70x10', 8000, 24, true, (SELECT id FROM categories WHERE name = 'Bolsas de Basura')),
('Basura Industrial UND', 'Bolsa basura industrial unidad', 3000, 12, true, (SELECT id FROM categories WHERE name = 'Bolsas de Basura')),
('Bolsa de Basura Blanca Verde Roja Kilo', 'Bolsa basura colores kilo', 10000, 9, true, (SELECT id FROM categories WHERE name = 'Bolsas de Basura')),
('Bolsa de Basura Industrial', 'Bolsa de basura industrial', 3500, 14, true, (SELECT id FROM categories WHERE name = 'Bolsas de Basura')),
('Bolsa de Basura Kilo', 'Bolsa de basura por kilo', 10000, 2, true, (SELECT id FROM categories WHERE name = 'Bolsas de Basura')),
('Bolsa Papelera 45x60 Colores', 'Bolsa papelera 45x60 colores', 6000, 15, true, (SELECT id FROM categories WHERE name = 'Bolsas de Basura')),
('Bolsa Papelera 45x60 Negra Kilo x 50', 'Bolsa papelera negra kilo x 50', 12000, 2, true, (SELECT id FROM categories WHERE name = 'Bolsas de Basura')),
('Bolsa Domicilio 21x15x32 (mediana)', 'Bolsa domicilio mediana', 5000, 18, true, (SELECT id FROM categories WHERE name = 'Bolsas de Basura'))
ON CONFLICT DO NOTHING;

-- Categoría: Contenedores
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('CONTENEDOR K1', 'Contenedor K1', 3000, 199, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('CONTENEDOR LITRO PQ X 24 TAPA', 'Contenedor litro paq x 24 con tapa', 25000, 1, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('CONTENEDOR TRASLUCIDO 6 ONZ PQX25', 'Contenedor traslúcido 6 onz paq x 25', 12000, 5, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('CONTENEDOR TRASLUCIDO 8 ONZ PQX25', 'Contenedor traslúcido 8 onz paq x 25', 14000, 4, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('CONTENEDOR TRASLUCIDO LITRO PQ X 25 DARNEL', 'Contenedor traslúcido litro paq x 25 Darnel', 20000, 12, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('Contenedor 16 onz Espumado', 'Contenedor 16 onz espumado', 8000, 47, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('Contenedor 24 onz Espumado paq x 20', 'Contenedor 24 onz espumado paq x 20', 12000, 20, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('Contenedor 4 divisiones Negro C/ Tapa Darnel', 'Contenedor 4 divisiones negro con tapa Darnel', 15000, 147, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('Contenedor 8 onz espumado', 'Contenedor 8 onz espumado', 6000, 20, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('Contenedor CARTON 16 ONZ CON TAPA', 'Contenedor cartón 16 onz con tapa', 10000, 12, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('PORTACOMIDAS C1', 'Portacomidas C1', 2500, 477, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('PORTACOMIDAS J1', 'Portacomidas J1', 3000, 139, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('PORTACOMIDAS J2', 'Portacomidas J2', 3500, 455, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('PORTACOMIDAS P1', 'Portacomidas P1', 2000, 1198, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('PORTACOMIDAS P3', 'Portacomidas P3', 2500, 617, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('C1 Bio caña Chevere paq. x 20', 'C1 Bio caña Chevere paq x 20', 8000, 23, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('J1 Bio caña Chevere', 'J1 Bio caña Chevere', 4000, 9, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('P3 Biocaña paq. x20', 'P3 Biocaña paq x 20', 7000, 9, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('PORTAPERRO PEQUEÑO PQ X 25', 'Portaperro pequeño paq x 25', 8000, 25, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('PORTAPERRO PEQUEÑO UNIDAD', 'Portaperro pequeño unidad', 500, 15, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('POSTRERO RECTANGULAR 16 ONZ TAPA ALTA', 'Postrero rectangular 16 onz tapa alta', 4000, 365, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('POSTRERO RECTANGULAR 8 ONZ TAPA BAJA', 'Postrero rectangular 8 onz tapa baja', 3000, 207, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('POSTRERO REDONDO TALLA M PQ X 25', 'Postrero redondo talla M paq x 25', 10000, 1, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('POSTRERO REDONDO TALLA S PQ X 25', 'Postrero redondo talla S paq x 25', 8000, 50, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('Ensaladera Kraf x 1.100 ml pq.x 25', 'Ensaladera Kraft 1100ml paq x 25', 15000, 44, true, (SELECT id FROM categories WHERE name = 'Contenedores')),
('Ensaladera Kraf x 750 ml pq x 24', 'Ensaladera Kraft 750ml paq x 24', 12000, 22, true, (SELECT id FROM categories WHERE name = 'Contenedores'))
ON CONFLICT DO NOTHING;

-- Categoría: Vasos Desechables
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('VASO 5 ONZ TRASLUCIDO', 'Vaso 5 onz traslúcido', 5000, 148, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('VASO BAR X 7 ONZ', 'Vaso bar 7 onz', 6000, 64, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('VASO 16 ONZ TRANS. GUTVAN', 'Vaso 16 onz transparente Gutvan', 10000, 14, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('VASO 16 ONZ PARA DOMO WAU', 'Vaso 16 onz para domo Wau', 8000, 3, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('VASO PARA DOMO 12 ONZ BIO GOLD WAU', 'Vaso para domo 12 onz Bio Gold Wau', 7000, 11, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('VASO PARA DOMO 14 ONZ BIO GOLD WAU', 'Vaso para domo 14 onz Bio Gold Wau', 8000, 10, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('VASO RESQ 12 ONZ DARNEL', 'Vaso Resq 12 onz Darnel', 8000, 28, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('VASO RESQ 16 ONZ DARNEL', 'Vaso Resq 16 onz Darnel', 10000, 10, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('VASO RESQ 9 ONZ DARNEL', 'Vaso Resq 9 onz Darnel', 7000, 27, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('VASO SICODELICO 3.5 ONZ', 'Vaso sicodélico 3.5 onz', 4000, 34, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('VASO TRANS. 14 ONZ GUTVAN', 'Vaso transparente 14 onz Gutvan', 9000, 31, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('Vaso 12 onz Opal Pet Chevere x 50', 'Vaso 12 onz Opal Pet Chevere x 50', 12000, 40, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('Vaso 3.3 oz verde x50', 'Vaso 3.3 onz verde x 50', 6000, 77, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('Vaso 3.5 onz Pq x 50', 'Vaso 3.5 onz paq x 50', 5000, 34, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('Vaso 4 onz con tapa', 'Vaso 4 onz con tapa', 6000, 14, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('Vaso 7 onz transparente pq x 50 sicodelico', 'Vaso 7 onz transparente paq x 50 sicodélico', 7000, 138, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('Vaso 7 onz Blanco Tuc', 'Vaso 7 onz blanco Tuc', 6000, 59, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('Vaso 9 oz Opal Pet Chevere x50', 'Vaso 9 onz Opal Pet Chevere x 50', 10000, 20, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('Vaso Vacan 12 onz Transp x 50', 'Vaso Vacan 12 onz transparente x 50', 10000, 75, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('Vaso Vacan 7 onz Trans paq x 50', 'Vaso Vacan 7 onz transparente paq x 50', 8000, 86, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('Vaso Whisky Chevere', 'Vaso whisky Chevere', 5000, 27, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('Vaso Helado 8 onz', 'Vaso helado 8 onz', 6000, 17, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('Vaso de helado x 4 onz', 'Vaso de helado 4 onz', 4000, 9, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('Vaso Murano 3 onz Cristal Darnel', 'Vaso Murano 3 onz cristal Darnel', 5000, 12, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('VASO ICOPOR 6 ONZ', 'Vaso icopor 6 onz', 4000, 22, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('Vaso Icopor 8 onz', 'Vaso icopor 8 onz', 5000, 80, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('Vaso icopor 10 oz', 'Vaso icopor 10 onz', 6000, 8, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('VASO ICOPOR 12 ONZ', 'Vaso icopor 12 onz', 7000, 51, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables')),
('VASO ICOPOR 16 ONZ', 'Vaso icopor 16 onz', 8000, 85, true, (SELECT id FROM categories WHERE name = 'Vasos Desechables'))
ON CONFLICT DO NOTHING;

-- Categoría: Vasos de Cartón
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('VASO CARTON 4 ONZ CHEVERE', 'Vaso cartón 4 onz Chevere', 5000, 116, true, (SELECT id FROM categories WHERE name = 'Vasos de Cartón')),
('Vaso de Carton 6 Onz Chevere x 50', 'Vaso de cartón 6 onz Chevere x 50', 8000, 71, true, (SELECT id FROM categories WHERE name = 'Vasos de Cartón')),
('Vaso de Carton 6 onz Darnel', 'Vaso de cartón 6 onz Darnel', 8000, 1, true, (SELECT id FROM categories WHERE name = 'Vasos de Cartón')),
('VASO DE CARTON 7 ONZ CHEVERE', 'Vaso de cartón 7 onz Chevere', 6000, 123, true, (SELECT id FROM categories WHERE name = 'Vasos de Cartón')),
('Vaso de Carton 7 oz Bio Form', 'Vaso de cartón 7 onz Bio Form', 6000, 4, true, (SELECT id FROM categories WHERE name = 'Vasos de Cartón')),
('VASO CARTON 9 ONZ CHEVERE', 'Vaso cartón 9 onz Chevere', 7000, 64, true, (SELECT id FROM categories WHERE name = 'Vasos de Cartón')),
('Vaso Carton 9 onz Bio Form', 'Vaso cartón 9 onz Bio Form', 7000, 5, true, (SELECT id FROM categories WHERE name = 'Vasos de Cartón')),
('Vaso de Carton 4 onz Bio Form', 'Vaso de cartón 4 onz Bio Form', 5000, 3, true, (SELECT id FROM categories WHERE name = 'Vasos de Cartón'))
ON CONFLICT DO NOTHING;

-- Categoría: Platos Desechables
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('PLATO HONDO ESP 5 ONZ', 'Plato hondo espumado 5 onz', 4000, 48, true, (SELECT id FROM categories WHERE name = 'Platos Desechables')),
('PLATO HONDO ESP 12 ONZ', 'Plato hondo espumado 12 onz', 6000, 33, true, (SELECT id FROM categories WHERE name = 'Platos Desechables')),
('Plato Hondo Esp. 25 onz', 'Plato hondo espumado 25 onz', 8000, 12, true, (SELECT id FROM categories WHERE name = 'Platos Desechables')),
('Plato hondo esp. 16 oz', 'Plato hondo espumado 16 onz', 7000, 40, true, (SELECT id FROM categories WHERE name = 'Platos Desechables')),
('Plato Pando 12 cm', 'Plato pando 12 cm', 3000, 55, true, (SELECT id FROM categories WHERE name = 'Platos Desechables')),
('PLATO PANDO 15.5 TORTERO ESPUMADO', 'Plato pando 15.5 tortero espumado', 5000, 98, true, (SELECT id FROM categories WHERE name = 'Platos Desechables')),
('PLATO PANDO 18 CM ESP.', 'Plato pando 18 cm espumado', 6000, 28, true, (SELECT id FROM categories WHERE name = 'Platos Desechables')),
('PLATO PANDO 20 CM', 'Plato pando 20 cm', 7000, 16, true, (SELECT id FROM categories WHERE name = 'Platos Desechables')),
('Plato Pando 20 cm.', 'Plato pando 20 cm', 7000, 15, true, (SELECT id FROM categories WHERE name = 'Platos Desechables')),
('PLATO PANDO ESP 23 CM', 'Plato pando espumado 23 cm', 8000, 113, true, (SELECT id FROM categories WHERE name = 'Platos Desechables')),
('Plato Pando 26 cms', 'Plato pando 26 cm', 9000, 3, true, (SELECT id FROM categories WHERE name = 'Platos Desechables')),
('PLATO PANDO BIO CHEVERE 15.5', 'Plato pando Bio Chevere 15.5', 6000, 30, true, (SELECT id FROM categories WHERE name = 'Platos Desechables')),
('Plato de Caña 23 cm', 'Plato de caña 23 cm', 8000, 18, true, (SELECT id FROM categories WHERE name = 'Platos Desechables')),
('Plato Cuadrado Petite Cristal Darnel', 'Plato cuadrado Petite cristal Darnel', 8000, 10, true, (SELECT id FROM categories WHERE name = 'Platos Desechables')),
('Plato Pando Geopack 15.5 x 20', 'Plato pando Geopack 15.5 x 20', 6000, 1, true, (SELECT id FROM categories WHERE name = 'Platos Desechables'))
ON CONFLICT DO NOTHING;

-- Categoría: Cubiertos Desechables
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('CUCHARA PEQUEÑA GOLAZO PQ X 100', 'Cuchara pequeña Golazo paq x 100', 5000, 155, true, (SELECT id FROM categories WHERE name = 'Cubiertos Desechables')),
('Cuchara Grande Golazo X 100', 'Cuchara grande Golazo x 100', 7000, 47, true, (SELECT id FROM categories WHERE name = 'Cubiertos Desechables')),
('Cuchillo Grande Deco', 'Cuchillo grande Deco', 7000, 18, true, (SELECT id FROM categories WHERE name = 'Cubiertos Desechables')),
('Cuchillo Grande Golazo', 'Cuchillo grande Golazo', 7000, 58, true, (SELECT id FROM categories WHERE name = 'Cubiertos Desechables')),
('Tenedor Golazo x 100', 'Tenedor Golazo x 100', 6000, 12, true, (SELECT id FROM categories WHERE name = 'Cubiertos Desechables')),
('Tenedor Grande Deco', 'Tenedor grande Deco', 6000, 29, true, (SELECT id FROM categories WHERE name = 'Cubiertos Desechables')),
('Tenedor Maderra House', 'Tenedor madera House', 8000, 3, true, (SELECT id FROM categories WHERE name = 'Cubiertos Desechables')),
('TENEDOR PEQUEÑO TAMI', 'Tenedor pequeño Tami', 4000, 6, true, (SELECT id FROM categories WHERE name = 'Cubiertos Desechables'))
ON CONFLICT DO NOTHING;

-- Categoría: Copas y Salseras
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('COPA 1 ONZ NEGRA', 'Copa 1 onz negra', 5000, 46, true, (SELECT id FROM categories WHERE name = 'Copas y Salseras')),
('COPA 1.5 ONZ PAQ X 50 DOMINGO', 'Copa 1.5 onz paq x 50 Domingo', 6000, 9, true, (SELECT id FROM categories WHERE name = 'Copas y Salseras')),
('COPA 1.5 ONZ PQ X 100 DARNEL', 'Copa 1.5 onz paq x 100 Darnel', 10000, 17, true, (SELECT id FROM categories WHERE name = 'Copas y Salseras')),
('COPA DOMINGO 1 ONZ Blanca', 'Copa Domingo 1 onz blanca', 5000, 260, true, (SELECT id FROM categories WHERE name = 'Copas y Salseras')),
('COPA FLAUTA PQ X 20', 'Copa flauta paq x 20', 8000, 12, true, (SELECT id FROM categories WHERE name = 'Copas y Salseras')),
('COPA SALSERA 1/2 ONZ CON TAPA X 50', 'Copa salsera 1/2 onz con tapa x 50', 6000, 52, true, (SELECT id FROM categories WHERE name = 'Copas y Salseras')),
('COPA SALSERA CON TAPA 1 ONZ X 50', 'Copa salsera con tapa 1 onz x 50', 7000, 37, true, (SELECT id FROM categories WHERE name = 'Copas y Salseras')),
('COPA SALSERA CON TAPA 2 ONZ X 50 TRASLUCIDA', 'Copa salsera con tapa 2 onz x 50 traslúcida', 8000, 46, true, (SELECT id FROM categories WHERE name = 'Copas y Salseras')),
('COPA SOUFLE 2 ONZ DARNEL PAQ X 100', 'Copa soufle 2 onz Darnel paq x 100', 12000, 25, true, (SELECT id FROM categories WHERE name = 'Copas y Salseras')),
('Copa Darnel Media onz x 100', 'Copa Darnel media onz x 100', 8000, 3, true, (SELECT id FROM categories WHERE name = 'Copas y Salseras')),
('Copa Murano 1,5 onz Cristal', 'Copa Murano 1.5 onz cristal', 6000, 10, true, (SELECT id FROM categories WHERE name = 'Copas y Salseras')),
('Copa Salsera 1,5 con tapa pq x 50', 'Copa salsera 1.5 con tapa paq x 50', 7000, 43, true, (SELECT id FROM categories WHERE name = 'Copas y Salseras')),
('Copa Salsera 1/2 onz Chevere x50', 'Copa salsera 1/2 onz Chevere x 50', 5000, 40, true, (SELECT id FROM categories WHERE name = 'Copas y Salseras')),
('Copa Salsera 2 onz Eco Life Paq x 50', 'Copa salsera 2 onz Eco Life paq x 50', 8000, 20, true, (SELECT id FROM categories WHERE name = 'Copas y Salseras')),
('Copa Veneciana 5 onz con tapa', 'Copa Veneciana 5 onz con tapa', 10000, 5, true, (SELECT id FROM categories WHERE name = 'Copas y Salseras')),
('Tasa Milano Tami 3 onz Paq x 25', 'Tasa Milano Tami 3 onz paq x 25', 8000, 40, true, (SELECT id FROM categories WHERE name = 'Copas y Salseras'))
ON CONFLICT DO NOTHING;

-- Categoría: Servilletas
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('SERVILLETA POPULAR X 200', 'Servilleta popular x 200', 5000, 37, true, (SELECT id FROM categories WHERE name = 'Servilletas')),
('Servilleta Bar paq x 110', 'Servilleta bar paq x 110', 4000, 88, true, (SELECT id FROM categories WHERE name = 'Servilletas')),
('Servilleta Cafeteria Skaap x180 chevere', 'Servilleta cafetería Skaap x 180 Chevere', 5000, 59, true, (SELECT id FROM categories WHERE name = 'Servilletas')),
('Servilleta Nube Una Una x 150', 'Servilleta Nube una una x 150', 5000, 14, true, (SELECT id FROM categories WHERE name = 'Servilletas')),
('Servilleta de Lujo Blank', 'Servilleta de lujo Blank', 6000, 36, true, (SELECT id FROM categories WHERE name = 'Servilletas')),
('Servilleta de Lujo Nube', 'Servilleta de lujo Nube', 6000, 301, true, (SELECT id FROM categories WHERE name = 'Servilletas'))
ON CONFLICT DO NOTHING;

-- Categoría: Toallas
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('TOALLA DE COCINA ROSAL', 'Toalla de cocina Rosal', 5000, 3, true, (SELECT id FROM categories WHERE name = 'Toallas')),
('TOALLA Z CHEVERE', 'Toalla Z Chevere', 6000, 297, true, (SELECT id FROM categories WHERE name = 'Toallas')),
('Toalla Center Pull Rollo Coltisu', 'Toalla center pull rollo Coltisu', 15000, 10, true, (SELECT id FROM categories WHERE name = 'Toallas')),
('Toalla Mia en V x 150 uds', 'Toalla Mia en V x 150 uds', 8000, 4, true, (SELECT id FROM categories WHERE name = 'Toallas')),
('Toalla Wipe Master x 200 paños Blanco', 'Toalla Wipe Master x 200 paños blanco', 12000, 3, true, (SELECT id FROM categories WHERE name = 'Toallas')),
('Toalla Wipe Pro 70 x 88 paños Task', 'Toalla Wipe Pro 70 x 88 paños Task', 15000, 6, true, (SELECT id FROM categories WHERE name = 'Toallas')),
('Toalla de Cocina Blank triple H x 80 h', 'Toalla de cocina Blank triple H x 80 hojas', 7000, 17, true, (SELECT id FROM categories WHERE name = 'Toallas')),
('Toalla de Cocina Blank x 130 H', 'Toalla de cocina Blank x 130 hojas', 9000, 8, true, (SELECT id FROM categories WHERE name = 'Toallas')),
('Toalla de Manos 100m*3 Blanca chevere', 'Toalla de manos 100m x 3 blanca Chevere', 10000, 17, true, (SELECT id FROM categories WHERE name = 'Toallas')),
('Toalla de manos Z Blank', 'Toalla de manos Z Blank', 8000, 18, true, (SELECT id FROM categories WHERE name = 'Toallas')),
('Toalla en Z blanca chevere x150', 'Toalla en Z blanca Chevere x 150', 6000, 48, true, (SELECT id FROM categories WHERE name = 'Toallas'))
ON CONFLICT DO NOTHING;

-- Categoría: Papel Aluminio y Vinipel
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('Papel Aluminio 300 mts Chevere', 'Papel aluminio 300 mts Chevere', 45000, 10, true, (SELECT id FROM categories WHERE name = 'Papel Aluminio y Vinipel')),
('Papel Aluminio x 100 mts Chevere', 'Papel aluminio 100 mts Chevere', 20000, 37, true, (SELECT id FROM categories WHERE name = 'Papel Aluminio y Vinipel')),
('Papel Aluminio x 16 mts Chevere', 'Papel aluminio 16 mts Chevere', 5000, 6, true, (SELECT id FROM categories WHERE name = 'Papel Aluminio y Vinipel')),
('Papel Aluminio x 40 mts Chevere', 'Papel aluminio 40 mts Chevere', 10000, 86, true, (SELECT id FROM categories WHERE name = 'Papel Aluminio y Vinipel')),
('Vinipel 100 mts Chevere', 'Vinipel 100 mts Chevere', 8000, 16, true, (SELECT id FROM categories WHERE name = 'Papel Aluminio y Vinipel')),
('Vinipel 50 mts Chevere', 'Vinipel 50 mts Chevere', 5000, 33, true, (SELECT id FROM categories WHERE name = 'Papel Aluminio y Vinipel')),
('Vinipel x 1400 mts Chevere', 'Vinipel 1400 mts Chevere', 60000, 2, true, (SELECT id FROM categories WHERE name = 'Papel Aluminio y Vinipel')),
('Vinipel x 200 mts. Chevere', 'Vinipel 200 mts Chevere', 12000, 13, true, (SELECT id FROM categories WHERE name = 'Papel Aluminio y Vinipel')),
('Vinipel x 300 mts. Chevere', 'Vinipel 300 mts Chevere', 18000, 29, true, (SELECT id FROM categories WHERE name = 'Papel Aluminio y Vinipel')),
('Vinipel x 500 mts Chevere', 'Vinipel 500 mts Chevere', 25000, 5, true, (SELECT id FROM categories WHERE name = 'Papel Aluminio y Vinipel')),
('LAMINA PAPEL PARAFINADO 29X29 CUADROS ROJOS PQ X 100', 'Lámina papel parafinado 29x29 cuadros rojos paq x 100', 8000, 3, true, (SELECT id FROM categories WHERE name = 'Papel Aluminio y Vinipel')),
('LAMINA PAPEL PARAFINADO 29X29 GENERICA PQ X 100', 'Lámina papel parafinado 29x29 genérica paq x 100', 7000, 5, true, (SELECT id FROM categories WHERE name = 'Papel Aluminio y Vinipel')),
('LAMINA PAPEL PARAFINADO 29X29 PQ X 100 CUADROS NEGROS', 'Lámina papel parafinado 29x29 cuadros negros paq x 100', 8000, 28, true, (SELECT id FROM categories WHERE name = 'Papel Aluminio y Vinipel')),
('PAPEL PARAFINADO CUADROS ROLLO X 50', 'Papel parafinado cuadros rollo x 50', 15000, 1, true, (SELECT id FROM categories WHERE name = 'Papel Aluminio y Vinipel')),
('PAPEL PARAFINADO ROLLO X 100 MTS', 'Papel parafinado rollo x 100 mts', 25000, 1, true, (SELECT id FROM categories WHERE name = 'Papel Aluminio y Vinipel')),
('PAPEL PARFINADO BLANCO ROLLO X 50 MTS', 'Papel parafinado blanco rollo x 50 mts', 15000, 3, true, (SELECT id FROM categories WHERE name = 'Papel Aluminio y Vinipel'))
ON CONFLICT DO NOTHING;

-- Categoría: Papel Higiénico
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('PAPEL HIGIENICO SCOTT CUIDADO COMPLETO PAC X 24', 'Papel higiénico Scott cuidado completo paq x 24', 35000, 4, true, (SELECT id FROM categories WHERE name = 'Papel Higiénico')),
('PAPEL HIGIENICO SCOTT RINDEMAX X 30 ROLLOS', 'Papel higiénico Scott Rindemax x 30 rollos', 40000, 5, true, (SELECT id FROM categories WHERE name = 'Papel Higiénico')),
('Papel Higienico Xtra-1 Natural x 200 mts', 'Papel higiénico Xtra-1 natural x 200 mts', 15000, 18, true, (SELECT id FROM categories WHERE name = 'Papel Higiénico')),
('Papel Smartone Nat. x 100 mts (xtra 1 mini)', 'Papel Smartone natural x 100 mts', 12000, 4, true, (SELECT id FROM categories WHERE name = 'Papel Higiénico')),
('Papel higienico Garden 250 mts', 'Papel higiénico Garden 250 mts', 18000, 100, true, (SELECT id FROM categories WHERE name = 'Papel Higiénico')),
('Rendipel jumbo 250mt', 'Rendipel jumbo 250 mts', 15000, 72, true, (SELECT id FROM categories WHERE name = 'Papel Higiénico'))
ON CONFLICT DO NOTHING;

-- Categoría: Limpieza General
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('Multilimpiador Fuller Galon 3.8lt', 'Multilimpiador Fuller galón 3.8lt', 25000, 78, true, (SELECT id FROM categories WHERE name = 'Limpieza General')),
('Multilimpiador pisos yilop poma 19L', 'Multilimpiador pisos Yilop poma 19L', 80000, 1, true, (SELECT id FROM categories WHERE name = 'Limpieza General')),
('Limpiavidrios TAK-TAX YILOP galon 3.8', 'Limpiavidrios Tak-Tax Yilop galón 3.8', 20000, 13, true, (SELECT id FROM categories WHERE name = 'Limpieza General')),
('Limpiavidrios C/pistola fco x 500', 'Limpiavidrios con pistola fco x 500', 8000, 1, true, (SELECT id FROM categories WHERE name = 'Limpieza General')),
('LIMPIAVIDRIOS EXTENSIBLE PINTO', 'Limpiavidrios extensible Pinto', 25000, 2, true, (SELECT id FROM categories WHERE name = 'Limpieza General')),
('Limpia pisos Dibianco poma', 'Limpia pisos Dibianco poma', 60000, 2, true, (SELECT id FROM categories WHERE name = 'Limpieza General')),
('ELIMINADOR DE OLORES DEOX', 'Eliminador de olores Deox', 12000, 15, true, (SELECT id FROM categories WHERE name = 'Limpieza General')),
('Varsol Ecologico fuller', 'Varsol ecológico Fuller', 15000, 5, true, (SELECT id FROM categories WHERE name = 'Limpieza General')),
('Shampoo Muebles y Alfombra', 'Shampoo muebles y alfombra', 15000, 5, true, (SELECT id FROM categories WHERE name = 'Limpieza General'))
ON CONFLICT DO NOTHING;

-- Categoría: Detergentes
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('Deergente en Polvo 3000gr (3kg) Super B', 'Detergente en polvo 3000gr Super B', 25000, 11, true, (SELECT id FROM categories WHERE name = 'Detergentes')),
('DETERGENTE LIQ POLARIX X 3 LTS', 'Detergente líquido Polarix x 3 lts', 20000, 1, true, (SELECT id FROM categories WHERE name = 'Detergentes')),
('Detergente Alto Desempeño Bio Cuñete', 'Detergente alto desempeño Bio cuñete', 80000, 5, true, (SELECT id FROM categories WHERE name = 'Detergentes')),
('Detergente Alto Desempeño Bio Galon', 'Detergente alto desempeño Bio galón', 25000, 19, true, (SELECT id FROM categories WHERE name = 'Detergentes')),
('Detergente Economico Bio Cuñete', 'Detergente económico Bio cuñete', 60000, 4, true, (SELECT id FROM categories WHERE name = 'Detergentes')),
('Detergente Economico Bio Galon', 'Detergente económico Bio galón', 18000, 2, true, (SELECT id FROM categories WHERE name = 'Detergentes')),
('Detergente Free 20 kg', 'Detergente Free 20 kg', 90000, 8, true, (SELECT id FROM categories WHERE name = 'Detergentes')),
('Detergente Neutro Andina GL3.8', 'Detergente neutro Andina galón 3.8', 22000, 19, true, (SELECT id FROM categories WHERE name = 'Detergentes')),
('Lavaloza Bio Galon', 'Lavaloza Bio galón', 20000, 6, true, (SELECT id FROM categories WHERE name = 'Detergentes')),
('Lavaloza liquido Thorflash Neutro YILOP Poma', 'Lavaloza líquido Thorflash neutro Yilop poma', 60000, 4, true, (SELECT id FROM categories WHERE name = 'Detergentes')),
('JABON REY BARRA', 'Jabón Rey barra', 3000, 113, true, (SELECT id FROM categories WHERE name = 'Detergentes')),
('JABON REY BARRA PAQ X 3 UDS', 'Jabón Rey barra paq x 3 uds', 8000, 31, true, (SELECT id FROM categories WHERE name = 'Detergentes'))
ON CONFLICT DO NOTHING;

-- Categoría: Escobas y Traperos
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('Escoba Aguamarina suave Rpto', 'Escoba Aguamarina suave repuesto', 8000, 15, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('Escoba Fibra Suave Pequeña Task', 'Escoba fibra suave pequeña Task', 10000, 1, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('Escoba Girasol Suave Repuesto', 'Escoba Girasol suave repuesto', 8000, 5, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('Escoba Orquidea Suave-Repuesto', 'Escoba Orquídea suave repuesto', 8000, 24, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('Escoba Suave Esmeralda', 'Escoba suave Esmeralda', 12000, 12, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('Escoba Suave Iris', 'Escoba suave Iris', 12000, 7, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('Escoba Zulia Suave', 'Escoba Zulia suave', 10000, 41, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('Trapero Blanco Repuesto x 450 grs', 'Trapero blanco repuesto x 450 grs', 12000, 3, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('Trapero Blanco y Negro Repuesto x 375 grs', 'Trapero blanco y negro repuesto x 375 grs', 10000, 11, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('Trapero Economico Grande', 'Trapero económico grande', 8000, 23, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('Trapero Microfibra Pinto 300 gr Rpto.', 'Trapero microfibra Pinto 300 gr repuesto', 15000, 11, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('Trapero Negro Repuesto x 250 gr', 'Trapero negro repuesto x 250 gr', 8000, 10, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('PALO METALICO X 1,20 M BLANCO', 'Palo metálico 1.20m blanco', 8000, 7, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('PALO METALICO X 1.40 ZULIA', 'Palo metálico 1.40m Zulia', 10000, 5, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('Mopa Microfibra C/Mango extendible', 'Mopa microfibra con mango extendible', 25000, 4, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('Brillador Algodon 59 cm Repuesto', 'Brillador algodón 59 cm repuesto', 12000, 6, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('Brillador Algodon 82 cm Repuesto', 'Brillador algodón 82 cm repuesto', 15000, 6, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('Armazon Metalico Brillador pequeño', 'Armazón metálico brillador pequeño', 20000, 2, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos')),
('Armazon Metalico para Brillador Grande', 'Armazón metálico para brillador grande', 25000, 2, true, (SELECT id FROM categories WHERE name = 'Escobas y Traperos'))
ON CONFLICT DO NOTHING;

-- Categoría: Esponjas y Fibras
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('La Maquina Fibra Pesada', 'La Máquina fibra pesada', 3000, 86, true, (SELECT id FROM categories WHERE name = 'Esponjas y Fibras')),
('Esponja Brillo Inoxidable Pinto', 'Esponja brillo inoxidable Pinto', 3000, 40, true, (SELECT id FROM categories WHERE name = 'Esponjas y Fibras')),
('Esponja Matrix alambre', 'Esponja Matrix alambre', 3000, 7, true, (SELECT id FROM categories WHERE name = 'Esponjas y Fibras')),
('Esponja Multiusos Arcoiris', 'Esponja multiusos Arcoíris', 2000, 85, true, (SELECT id FROM categories WHERE name = 'Esponjas y Fibras')),
('Esponja Ollas y Parrillas', 'Esponja ollas y parrillas', 3500, 38, true, (SELECT id FROM categories WHERE name = 'Esponjas y Fibras')),
('Esponjilla Dorada Plateada Trabajo Pesado Pinto', 'Esponjilla dorada plateada trabajo pesado Pinto', 3000, 24, true, (SELECT id FROM categories WHERE name = 'Esponjas y Fibras')),
('Esponjilla Dorada-Plateada x 3 Pinto', 'Esponjilla dorada-plateada x 3 Pinto', 5000, 9, true, (SELECT id FROM categories WHERE name = 'Esponjas y Fibras')),
('ESPONJA POLARIX COLOR FUERTE PQ X 3', 'Esponja Polarix color fuerte paq x 3', 5000, 2, true, (SELECT id FROM categories WHERE name = 'Esponjas y Fibras')),
('ESPONJA POLARIX ORO PLATA PQ X 3', 'Esponja Polarix oro plata paq x 3', 5000, 1, true, (SELECT id FROM categories WHERE name = 'Esponjas y Fibras')),
('Fibra de amarre 700Ms', 'Fibra de amarre 700 mts', 8000, 16, true, (SELECT id FROM categories WHERE name = 'Esponjas y Fibras'))
ON CONFLICT DO NOTHING;

-- Categoría: Desinfectantes
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('Blanqueador Concentrado Tak Tax Galon', 'Blanqueador concentrado Tak Tax galón', 15000, 22, true, (SELECT id FROM categories WHERE name = 'Desinfectantes')),
('Blanqueador Poma Yilop', 'Blanqueador poma Yilop', 50000, 9, true, (SELECT id FROM categories WHERE name = 'Desinfectantes')),
('Desengrasante Industrial Galon 3.8lt', 'Desengrasante industrial galón 3.8lt', 20000, 17, true, (SELECT id FROM categories WHERE name = 'Desinfectantes')),
('Desengrasante Tak Tax Multiusos Poma YILOP', 'Desengrasante Tak Tax multiusos poma Yilop', 60000, 5, true, (SELECT id FROM categories WHERE name = 'Desinfectantes')),
('Desmanchador Concentrado Tak Tax Poma', 'Desmanchador concentrado Tak Tax poma', 60000, 2, true, (SELECT id FROM categories WHERE name = 'Desinfectantes')),
('Desmanchador de Juntas TAK-TAK YILOP', 'Desmanchador de juntas Tak-Tak Yilop', 12000, 14, true, (SELECT id FROM categories WHERE name = 'Desinfectantes')),
('DESMANCHADOR DE JUNTAS CWIC', 'Desmanchador de juntas Cwic', 10000, 8, true, (SELECT id FROM categories WHERE name = 'Desinfectantes')),
('Alcohol Silquin 750 ml', 'Alcohol Silquin 750 ml', 8000, 407, true, (SELECT id FROM categories WHERE name = 'Desinfectantes')),
('Cera Autobrillante PolimericaBlanca Yilop', 'Cera autobrillante polimérica blanca Yilop', 25000, 13, true, (SELECT id FROM categories WHERE name = 'Desinfectantes')),
('Cera autobrillante polimerica yilop roja', 'Cera autobrillante polimérica roja Yilop', 25000, 23, true, (SELECT id FROM categories WHERE name = 'Desinfectantes'))
ON CONFLICT DO NOTHING;

-- Categoría: Ambientadores
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('AMBIENTADOR BONAIRE X 400 SPRAY', 'Ambientador Bonaire x 400 spray', 12000, 22, true, (SELECT id FROM categories WHERE name = 'Ambientadores')),
('Ambientador Gel Hogar 70gr', 'Ambientador gel hogar 70gr', 5000, 60, true, (SELECT id FROM categories WHERE name = 'Ambientadores')),
('Ambientador de varitas Full', 'Ambientador de varitas Full', 10000, 40, true, (SELECT id FROM categories WHERE name = 'Ambientadores')),
('Sales de Olor Bio', 'Sales de olor Bio', 5000, 1, true, (SELECT id FROM categories WHERE name = 'Ambientadores'))
ON CONFLICT DO NOTHING;

-- Categoría: Guantes
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('GUANTE NITRILO HOUSE NEGRO CJ X 100', 'Guante nitrilo House negro caja x 100', 35000, 98, true, (SELECT id FROM categories WHERE name = 'Guantes')),
('Guante Bicolor C-25 Rey', 'Guante bicolor C-25 Rey', 8000, 146, true, (SELECT id FROM categories WHERE name = 'Guantes')),
('Guante Nitrilo Par Talla M', 'Guante nitrilo par talla M', 3000, 13, true, (SELECT id FROM categories WHERE name = 'Guantes')),
('Guante de Manipulacion de Alimentos House', 'Guante de manipulación de alimentos House', 25000, 78, true, (SELECT id FROM categories WHERE name = 'Guantes')),
('Guante de Manipulacion de Alimentos Mega', 'Guante de manipulación de alimentos Mega', 20000, 15, true, (SELECT id FROM categories WHERE name = 'Guantes'))
ON CONFLICT DO NOTHING;

-- Categoría: Tapabocas y Gorros
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('Gorro Oruga x 100 Blanco Chevere', 'Gorro oruga x 100 blanco Chevere', 12000, 28, true, (SELECT id FROM categories WHERE name = 'Tapabocas y Gorros')),
('Tapabocas emp. Individual', 'Tapabocas empaque individual', 500, 6, true, (SELECT id FROM categories WHERE name = 'Tapabocas y Gorros')),
('Tapabocas x 50', 'Tapabocas x 50', 12000, 47, true, (SELECT id FROM categories WHERE name = 'Tapabocas y Gorros'))
ON CONFLICT DO NOTHING;

-- Categoría: Palillos y Mezcladores
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('PALILLO COCTAIL CON NUDO CHEVERE', 'Palillo cocktail con nudo Chevere', 5000, 98, true, (SELECT id FROM categories WHERE name = 'Palillos y Mezcladores')),
('Palillo Cocktail nudo Chevere x100', 'Palillo cocktail nudo Chevere x 100', 6000, 98, true, (SELECT id FROM categories WHERE name = 'Palillos y Mezcladores')),
('PALILLO HAMBURGUESA CHEVERE', 'Palillo hamburguesa Chevere', 3000, 133, true, (SELECT id FROM categories WHERE name = 'Palillos y Mezcladores')),
('PALILLO REDONDO DOBLE PUNTA CHEVERE', 'Palillo redondo doble punta Chevere', 2000, 408, true, (SELECT id FROM categories WHERE name = 'Palillos y Mezcladores')),
('PALO BROCHETA CHEVERE', 'Palo brocheta Chevere', 4000, 122, true, (SELECT id FROM categories WHERE name = 'Palillos y Mezcladores')),
('PINCHUZO CHEVERE X 25 CM', 'Pinchuzo Chevere x 25 cm', 3000, 151, true, (SELECT id FROM categories WHERE name = 'Palillos y Mezcladores')),
('Pinchuzo Chevere x 30 cm', 'Pinchuzo Chevere x 30 cm', 3500, 50, true, (SELECT id FROM categories WHERE name = 'Palillos y Mezcladores')),
('MEZCLADOR BIO CHEVERE', 'Mezclador Bio Chevere', 4000, 8, true, (SELECT id FROM categories WHERE name = 'Palillos y Mezcladores')),
('MEZCLADOR MADERA CHEVERE 14 CM', 'Mezclador madera Chevere 14 cm', 3000, 17, true, (SELECT id FROM categories WHERE name = 'Palillos y Mezcladores')),
('Palita de Madera', 'Palita de madera', 2000, 47, true, (SELECT id FROM categories WHERE name = 'Palillos y Mezcladores')),
('Palo Paleta Corto paq. x 100', 'Palo paleta corto paq x 100', 5000, 5, true, (SELECT id FROM categories WHERE name = 'Palillos y Mezcladores')),
('Palo Paleta x 1000', 'Palo paleta x 1000', 15000, 20, true, (SELECT id FROM categories WHERE name = 'Palillos y Mezcladores'))
ON CONFLICT DO NOTHING;

-- Categoría: Tapas
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('TAPA DOMO RESQ DARNEL', 'Tapa domo Resq Darnel', 8000, 10, true, (SELECT id FROM categories WHERE name = 'Tapas')),
('TAPA DOMO VASO BIO GOLD 9,12,14,16 ONZ PQ X 50', 'Tapa domo vaso Bio Gold 9,12,14,16 onz paq x 50', 10000, 20, true, (SELECT id FROM categories WHERE name = 'Tapas')),
('TAPA VASO CARTON 9 ONZ CHEVERE', 'Tapa vaso cartón 9 onz Chevere', 5000, 28, true, (SELECT id FROM categories WHERE name = 'Tapas')),
('TAPA VASO CARTON 7 ONZ CHEVERE', 'Tapa vaso cartón 7 onz Chevere', 4500, 42, true, (SELECT id FROM categories WHERE name = 'Tapas')),
('Tapa Darnel 1 oz- 1/2 oz x 100', 'Tapa Darnel 1 oz - 1/2 oz x 100', 8000, 43, true, (SELECT id FROM categories WHERE name = 'Tapas')),
('Tapa Domo Vaso helado 8 onz', 'Tapa domo vaso helado 8 onz', 6000, 17, true, (SELECT id FROM categories WHERE name = 'Tapas')),
('Tapa Domo vaso helado 4 onz', 'Tapa domo vaso helado 4 onz', 5000, 19, true, (SELECT id FROM categories WHERE name = 'Tapas')),
('Tapa Pet 12 oz Chevere x 50', 'Tapa Pet 12 oz Chevere x 50', 8000, 40, true, (SELECT id FROM categories WHERE name = 'Tapas')),
('Tapa Pet 7-9 oz Chevere x50', 'Tapa Pet 7-9 oz Chevere x 50', 7000, 20, true, (SELECT id FROM categories WHERE name = 'Tapas')),
('Tapa Plana Vaso de Carton 9oz Bio Form', 'Tapa plana vaso de cartón 9oz Bio Form', 5000, 9, true, (SELECT id FROM categories WHERE name = 'Tapas')),
('Tapa Plana vaso de carton 7 oz Bio Form', 'Tapa plana vaso de cartón 7 oz Bio Form', 4500, 7, true, (SELECT id FROM categories WHERE name = 'Tapas')),
('Tapa Vaso Icopor 10 onz Paq x 20 uds', 'Tapa vaso icopor 10 onz paq x 20 uds', 5000, 41, true, (SELECT id FROM categories WHERE name = 'Tapas')),
('Tapa Vaso Vacan 9-10-12 Onz paq x 50', 'Tapa vaso Vacan 9-10-12 onz paq x 50', 8000, 94, true, (SELECT id FROM categories WHERE name = 'Tapas'))
ON CONFLICT DO NOTHING;

-- Categoría: Cuidado Personal
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('Acondicionador Nutribela Caja x 12 sobres', 'Acondicionador Nutribela caja x 12 sobres', 8000, 15, true, (SELECT id FROM categories WHERE name = 'Cuidado Personal')),
('Shampo Nutribela Caja x 12 sobres', 'Shampoo Nutribela caja x 12 sobres', 8000, 17, true, (SELECT id FROM categories WHERE name = 'Cuidado Personal')),
('Jabon Cremoso Avena Sibyla', 'Jabón cremoso avena Sibyla', 5000, 18, true, (SELECT id FROM categories WHERE name = 'Cuidado Personal')),
('Jabon Glicerinado Galon 3.8 lt Dibianco', 'Jabón glicerinado galón 3.8 lt Dibianco', 25000, 7, true, (SELECT id FROM categories WHERE name = 'Cuidado Personal')),
('Jabon Sibyla Frutos rojos', 'Jabón Sibyla frutos rojos', 5000, 18, true, (SELECT id FROM categories WHERE name = 'Cuidado Personal')),
('Jabon Suite Hotel Display x 24', 'Jabón Suite Hotel display x 24', 15000, 5, true, (SELECT id FROM categories WHERE name = 'Cuidado Personal')),
('Pañios Humedos Pequeñin x 60', 'Paños húmedos Pequeñín x 60', 8000, 2, true, (SELECT id FROM categories WHERE name = 'Cuidado Personal')),
('Paños Humedos Pequeño', 'Paños húmedos pequeño', 5000, 7, true, (SELECT id FROM categories WHERE name = 'Cuidado Personal')),
('Pañuelos faciales CADA UNO', 'Pañuelos faciales cada uno', 500, 20, true, (SELECT id FROM categories WHERE name = 'Cuidado Personal'))
ON CONFLICT DO NOTHING;

-- Categoría: Bandejas y Moldes
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('Bandeja # 3', 'Bandeja # 3', 3000, 260, true, (SELECT id FROM categories WHERE name = 'Bandejas y Moldes')),
('Base Torta # 17', 'Base torta # 17', 2000, 9, true, (SELECT id FROM categories WHERE name = 'Bandejas y Moldes')),
('Base Torta # 21', 'Base torta # 21', 2500, 26, true, (SELECT id FROM categories WHERE name = 'Bandejas y Moldes')),
('Base Torta # 24', 'Base torta # 24', 3000, 40, true, (SELECT id FROM categories WHERE name = 'Bandejas y Moldes')),
('MOLDE DE ALUMINIO LASAÑA 16 ONZ PQ X 20', 'Molde de aluminio lasaña 16 onz paq x 20', 15000, 10, true, (SELECT id FROM categories WHERE name = 'Bandejas y Moldes')),
('Molde Lasaña 16 onz Unidad', 'Molde lasaña 16 onz unidad', 1000, 800, true, (SELECT id FROM categories WHERE name = 'Bandejas y Moldes')),
('Molde Lasaña Carta Unidad', 'Molde lasaña carta unidad', 1500, 93, true, (SELECT id FROM categories WHERE name = 'Bandejas y Moldes')),
('Molde Muffin Pan x50', 'Molde muffin pan x 50', 10000, 20, true, (SELECT id FROM categories WHERE name = 'Bandejas y Moldes'))
ON CONFLICT DO NOTHING;

-- Categoría: Accesorios de Limpieza
INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('Cepillo Paredes y Techos s/Mango', 'Cepillo paredes y techos sin mango', 15000, 4, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('Cepillo Mano Plancha Grande', 'Cepillo mano plancha grande', 5000, 6, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('Cepillo Mano Pequeño', 'Cepillo mano pequeño', 3000, 3, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('Cepillo Plancha Neon', 'Cepillo plancha neon', 4000, 5, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('Cepillo Plancha Pinto - Imusa', 'Cepillo plancha Pinto - Imusa', 6000, 1, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('Destapador de baño con mango', 'Destapador de baño con mango', 8000, 12, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('Recogedor con Banda Pinto', 'Recogedor con banda Pinto', 10000, 8, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('Secador de Caucho 60 cms repuesto', 'Secador de caucho 60 cms repuesto', 12000, 6, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('Secador de caucho 38 cm sin mango', 'Secador de caucho 38 cm sin mango', 8000, 3, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('Cesta Basura Pequeña', 'Cesta basura pequeña', 10000, 1, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('Plumero Arcoiris con Mango', 'Plumero Arcoíris con mango', 8000, 3, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('PAÑO MICROFIBRA PQ X 5', 'Paño microfibra paq x 5', 15000, 14, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('Paño Microfibra Pinto Ud', 'Paño microfibra Pinto unidad', 4000, 12, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('FRANELA 36X50 FILETEADA', 'Franela 36x50 fileteada', 5000, 16, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('PASTA POLARIX PAQ X 3 SANITARIO', 'Pasta Polarix paq x 3 sanitario', 8000, 9, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('Pegante Inst. Durita', 'Pegante instantáneo Durita', 2000, 20, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('SUAVIZANTE POLARIX X 3 LTS', 'Suavizante Polarix x 3 lts', 18000, 2, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('Suavizante Bio Cuñete', 'Suavizante Bio cuñete', 60000, 6, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('Suavizante Bio Galon', 'Suavizante Bio galón', 18000, 4, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('FOSFORO GRANDE PAR', 'Fósforo grande par', 3000, 18, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza')),
('FOSFORO PEQUEÑO PAQ X 20', 'Fósforo pequeño paq x 20', 5000, 2, true, (SELECT id FROM categories WHERE name = 'Accesorios de Limpieza'))
ON CONFLICT DO NOTHING;

-- Categoría: Pitillos
INSERT INTO categories (name, description) VALUES
('Pitillos', 'Pitillos y pajillas para bebidas')
ON CONFLICT (name) DO NOTHING;

INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('PITILLO BIOCHEVERE EMPACADO X 200', 'Pitillo Bio Chevere empacado x 200', 8000, 25, true, (SELECT id FROM categories WHERE name = 'Pitillos')),
('PITILLO JUMBO CUCHARA COLORES X 200', 'Pitillo jumbo cuchara colores x 200', 10000, 10, true, (SELECT id FROM categories WHERE name = 'Pitillos')),
('PITILLO DE ALMIDON CUCHARA PQ X 150', 'Pitillo de almidón cuchara paq x 150', 12000, 29, true, (SELECT id FROM categories WHERE name = 'Pitillos')),
('PITILLO SORBIFLEX PQ X 100', 'Pitillo Sorbiflex paq x 100', 5000, 58, true, (SELECT id FROM categories WHERE name = 'Pitillos')),
('Pitillo Bio Fresh empacado x 500', 'Pitillo Bio Fresh empacado x 500', 15000, 1, true, (SELECT id FROM categories WHERE name = 'Pitillos')),
('Pitillo Chevere Flex color x 200', 'Pitillo Chevere flex color x 200', 6000, 39, true, (SELECT id FROM categories WHERE name = 'Pitillos')),
('Pitillo Sorbete Chevere paq. x 200', 'Pitillo sorbete Chevere paq x 200', 5000, 40, true, (SELECT id FROM categories WHERE name = 'Pitillos'))
ON CONFLICT DO NOTHING;

-- Categoría: Bolsas Especiales (Manicure/Pedicure)
INSERT INTO categories (name, description) VALUES
('Bolsas Especiales', 'Bolsas para manicure, pedicure y otros usos')
ON CONFLICT (name) DO NOTHING;

INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('Bolsa Manicure Paq x 50 Transparente', 'Bolsa manicure paq x 50 transparente', 8000, 10, true, (SELECT id FROM categories WHERE name = 'Bolsas Especiales')),
('Bolsa Pedicure pq x 50 Transparente', 'Bolsa pedicure paq x 50 transparente', 10000, 10, true, (SELECT id FROM categories WHERE name = 'Bolsas Especiales'))
ON CONFLICT DO NOTHING;

-- Categoría: Azúcar y Abarrotes
INSERT INTO categories (name, description) VALUES
('Abarrotes', 'Azúcar y productos de abarrotes')
ON CONFLICT (name) DO NOTHING;

INSERT INTO products (name, description, price, stock, is_active, category_id) VALUES
('Azucar Kilo en sobres', 'Azúcar kilo en sobres', 5000, 5, true, (SELECT id FROM categories WHERE name = 'Abarrotes'))
ON CONFLICT DO NOTHING;

-- Verificar resultado
SELECT 'Categorías creadas:' as info, COUNT(*) as total FROM categories;
SELECT 'Productos creados:' as info, COUNT(*) as total FROM products;
