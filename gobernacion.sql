PGDMP  )    1                 }            servicioComunitario    17.2    17.2 e    t           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            u           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            v           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            w           1262    16387    servicioComunitario    DATABASE     �   CREATE DATABASE "servicioComunitario" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Venezuela.1252';
 %   DROP DATABASE "servicioComunitario";
                     postgres    false            s           1247    16757    tipo_documento_enum    TYPE     N   CREATE TYPE public.tipo_documento_enum AS ENUM (
    'V',
    'J',
    'E'
);
 &   DROP TYPE public.tipo_documento_enum;
       public               postgres    false            �            1255    16703    actualizar_updated_at()    FUNCTION     �   CREATE FUNCTION public.actualizar_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;
 .   DROP FUNCTION public.actualizar_updated_at();
       public               postgres    false            �            1259    16799    bancos    TABLE     �   CREATE TABLE public.bancos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    codigo_banco character varying(20) NOT NULL
);
    DROP TABLE public.bancos;
       public         heap r       postgres    false            �            1259    16798    bancos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bancos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.bancos_id_seq;
       public               postgres    false    232            x           0    0    bancos_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.bancos_id_seq OWNED BY public.bancos.id;
          public               postgres    false    231            �            1259    16834 
   beneficios    TABLE     �   CREATE TABLE public.beneficios (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    activo boolean DEFAULT true
);
    DROP TABLE public.beneficios;
       public         heap r       postgres    false            �            1259    16833    beneficios_id_seq    SEQUENCE     �   CREATE SEQUENCE public.beneficios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.beneficios_id_seq;
       public               postgres    false    236            y           0    0    beneficios_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.beneficios_id_seq OWNED BY public.beneficios.id;
          public               postgres    false    235            �            1259    16706    familias    TABLE     i   CREATE TABLE public.familias (
    id integer NOT NULL,
    direccion character varying(255) NOT NULL
);
    DROP TABLE public.familias;
       public         heap r       postgres    false            �            1259    16705    familias_id_seq    SEQUENCE     �   CREATE SEQUENCE public.familias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.familias_id_seq;
       public               postgres    false    222            z           0    0    familias_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.familias_id_seq OWNED BY public.familias.id;
          public               postgres    false    221            �            1259    16764    historial_pagos    TABLE     �   CREATE TABLE public.historial_pagos (
    id integer NOT NULL,
    usuario_familia_id integer NOT NULL,
    monto numeric(10,2) NOT NULL,
    fecha_pago date DEFAULT CURRENT_DATE,
    banco_id integer
);
 #   DROP TABLE public.historial_pagos;
       public         heap r       postgres    false            �            1259    16763    historial_pagos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.historial_pagos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.historial_pagos_id_seq;
       public               postgres    false    228            {           0    0    historial_pagos_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.historial_pagos_id_seq OWNED BY public.historial_pagos.id;
          public               postgres    false    227            �            1259    16713    jefe_familia    TABLE     �   CREATE TABLE public.jefe_familia (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    familia_id integer NOT NULL
);
     DROP TABLE public.jefe_familia;
       public         heap r       postgres    false            �            1259    16712    jefe_familia_id_seq    SEQUENCE     �   CREATE SEQUENCE public.jefe_familia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.jefe_familia_id_seq;
       public               postgres    false    224            |           0    0    jefe_familia_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.jefe_familia_id_seq OWNED BY public.jefe_familia.id;
          public               postgres    false    223            �            1259    16894    pagos    TABLE     &  CREATE TABLE public.pagos (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    monto numeric(10,2) NOT NULL,
    banco_id integer NOT NULL,
    beneficio_id integer NOT NULL,
    fecha timestamp without time zone DEFAULT now() NOT NULL,
    codigo_referencia character varying(6)
);
    DROP TABLE public.pagos;
       public         heap r       postgres    false            �            1259    16893    pagos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pagos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.pagos_id_seq;
       public               postgres    false    238            }           0    0    pagos_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.pagos_id_seq OWNED BY public.pagos.id;
          public               postgres    false    237            �            1259    16813    referencias_pago    TABLE     �   CREATE TABLE public.referencias_pago (
    id integer NOT NULL,
    pago_id integer NOT NULL,
    referencia_pago character varying(100) NOT NULL,
    tipo_pago character varying(50) NOT NULL,
    fecha_pago date DEFAULT CURRENT_DATE
);
 $   DROP TABLE public.referencias_pago;
       public         heap r       postgres    false            �            1259    16812    referencias_pago_id_seq    SEQUENCE     �   CREATE SEQUENCE public.referencias_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.referencias_pago_id_seq;
       public               postgres    false    234            ~           0    0    referencias_pago_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.referencias_pago_id_seq OWNED BY public.referencias_pago.id;
          public               postgres    false    233            �            1259    16674    roles    TABLE     b   CREATE TABLE public.roles (
    id integer NOT NULL,
    nombre character varying(20) NOT NULL
);
    DROP TABLE public.roles;
       public         heap r       postgres    false            �            1259    16673    roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public               postgres    false    218                       0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
          public               postgres    false    217            �            1259    16727    usuario_familia    TABLE     �   CREATE TABLE public.usuario_familia (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    familia_id integer NOT NULL
);
 #   DROP TABLE public.usuario_familia;
       public         heap r       postgres    false            �            1259    16726    usuario_familia_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_familia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.usuario_familia_id_seq;
       public               postgres    false    226            �           0    0    usuario_familia_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.usuario_familia_id_seq OWNED BY public.usuario_familia.id;
          public               postgres    false    225            �            1259    16777    usuario_familia_pago    TABLE     �   CREATE TABLE public.usuario_familia_pago (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    familia_id integer NOT NULL,
    pago_id integer NOT NULL
);
 (   DROP TABLE public.usuario_familia_pago;
       public         heap r       postgres    false            �            1259    16776    usuario_familia_pago_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_familia_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.usuario_familia_pago_id_seq;
       public               postgres    false    230            �           0    0    usuario_familia_pago_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.usuario_familia_pago_id_seq OWNED BY public.usuario_familia_pago.id;
          public               postgres    false    229            �            1259    16684    usuarios    TABLE     �  CREATE TABLE public.usuarios (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    correo character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    rol_id integer NOT NULL,
    nombre character varying(100),
    apellido character varying(100),
    tipo_cedula character varying(1),
    numero_cedula character varying(8),
    CONSTRAINT usuarios_tipo_cedula_check CHECK (((tipo_cedula)::text = ANY ((ARRAY['V'::character varying, 'J'::character varying, 'E'::character varying])::text[])))
);
    DROP TABLE public.usuarios;
       public         heap r       postgres    false            �            1259    16683    usuarios_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.usuarios_id_seq;
       public               postgres    false    220            �           0    0    usuarios_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;
          public               postgres    false    219            �           2604    16802 	   bancos id    DEFAULT     f   ALTER TABLE ONLY public.bancos ALTER COLUMN id SET DEFAULT nextval('public.bancos_id_seq'::regclass);
 8   ALTER TABLE public.bancos ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    231    232    232            �           2604    16837    beneficios id    DEFAULT     n   ALTER TABLE ONLY public.beneficios ALTER COLUMN id SET DEFAULT nextval('public.beneficios_id_seq'::regclass);
 <   ALTER TABLE public.beneficios ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    235    236    236            �           2604    16709    familias id    DEFAULT     j   ALTER TABLE ONLY public.familias ALTER COLUMN id SET DEFAULT nextval('public.familias_id_seq'::regclass);
 :   ALTER TABLE public.familias ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    221    222    222            �           2604    16767    historial_pagos id    DEFAULT     x   ALTER TABLE ONLY public.historial_pagos ALTER COLUMN id SET DEFAULT nextval('public.historial_pagos_id_seq'::regclass);
 A   ALTER TABLE public.historial_pagos ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    228    227    228            �           2604    16716    jefe_familia id    DEFAULT     r   ALTER TABLE ONLY public.jefe_familia ALTER COLUMN id SET DEFAULT nextval('public.jefe_familia_id_seq'::regclass);
 >   ALTER TABLE public.jefe_familia ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    223    224    224            �           2604    16897    pagos id    DEFAULT     d   ALTER TABLE ONLY public.pagos ALTER COLUMN id SET DEFAULT nextval('public.pagos_id_seq'::regclass);
 7   ALTER TABLE public.pagos ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    237    238    238            �           2604    16816    referencias_pago id    DEFAULT     z   ALTER TABLE ONLY public.referencias_pago ALTER COLUMN id SET DEFAULT nextval('public.referencias_pago_id_seq'::regclass);
 B   ALTER TABLE public.referencias_pago ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    233    234    234            �           2604    16677    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    218    217    218            �           2604    16730    usuario_familia id    DEFAULT     x   ALTER TABLE ONLY public.usuario_familia ALTER COLUMN id SET DEFAULT nextval('public.usuario_familia_id_seq'::regclass);
 A   ALTER TABLE public.usuario_familia ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    225    226    226            �           2604    16780    usuario_familia_pago id    DEFAULT     �   ALTER TABLE ONLY public.usuario_familia_pago ALTER COLUMN id SET DEFAULT nextval('public.usuario_familia_pago_id_seq'::regclass);
 F   ALTER TABLE public.usuario_familia_pago ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    229    230    230            �           2604    16687    usuarios id    DEFAULT     j   ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);
 :   ALTER TABLE public.usuarios ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    220    219    220            k          0    16799    bancos 
   TABLE DATA           :   COPY public.bancos (id, nombre, codigo_banco) FROM stdin;
    public               postgres    false    232   �z       o          0    16834 
   beneficios 
   TABLE DATA           8   COPY public.beneficios (id, nombre, activo) FROM stdin;
    public               postgres    false    236   v{       a          0    16706    familias 
   TABLE DATA           1   COPY public.familias (id, direccion) FROM stdin;
    public               postgres    false    222   �{       g          0    16764    historial_pagos 
   TABLE DATA           ^   COPY public.historial_pagos (id, usuario_familia_id, monto, fecha_pago, banco_id) FROM stdin;
    public               postgres    false    228   �{       c          0    16713    jefe_familia 
   TABLE DATA           >   COPY public.jefe_familia (id, nombre, familia_id) FROM stdin;
    public               postgres    false    224   �{       q          0    16894    pagos 
   TABLE DATA           h   COPY public.pagos (id, usuario_id, monto, banco_id, beneficio_id, fecha, codigo_referencia) FROM stdin;
    public               postgres    false    238   �{       m          0    16813    referencias_pago 
   TABLE DATA           _   COPY public.referencias_pago (id, pago_id, referencia_pago, tipo_pago, fecha_pago) FROM stdin;
    public               postgres    false    234   $}       ]          0    16674    roles 
   TABLE DATA           +   COPY public.roles (id, nombre) FROM stdin;
    public               postgres    false    218   A}       e          0    16727    usuario_familia 
   TABLE DATA           E   COPY public.usuario_familia (id, usuario_id, familia_id) FROM stdin;
    public               postgres    false    226   �}       i          0    16777    usuario_familia_pago 
   TABLE DATA           S   COPY public.usuario_familia_pago (id, usuario_id, familia_id, pago_id) FROM stdin;
    public               postgres    false    230   �}       _          0    16684    usuarios 
   TABLE DATA           �   COPY public.usuarios (id, username, password, correo, created_at, updated_at, rol_id, nombre, apellido, tipo_cedula, numero_cedula) FROM stdin;
    public               postgres    false    220   �}       �           0    0    bancos_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.bancos_id_seq', 10, true);
          public               postgres    false    231            �           0    0    beneficios_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.beneficios_id_seq', 2, true);
          public               postgres    false    235            �           0    0    familias_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.familias_id_seq', 1, false);
          public               postgres    false    221            �           0    0    historial_pagos_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.historial_pagos_id_seq', 1, false);
          public               postgres    false    227            �           0    0    jefe_familia_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.jefe_familia_id_seq', 3, true);
          public               postgres    false    223            �           0    0    pagos_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.pagos_id_seq', 14, true);
          public               postgres    false    237            �           0    0    referencias_pago_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.referencias_pago_id_seq', 1, false);
          public               postgres    false    233            �           0    0    roles_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.roles_id_seq', 3, true);
          public               postgres    false    217            �           0    0    usuario_familia_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.usuario_familia_id_seq', 1, false);
          public               postgres    false    225            �           0    0    usuario_familia_pago_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.usuario_familia_pago_id_seq', 1, false);
          public               postgres    false    229            �           0    0    usuarios_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.usuarios_id_seq', 10, true);
          public               postgres    false    219            �           2606    16806    bancos bancos_codigo_banco_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.bancos
    ADD CONSTRAINT bancos_codigo_banco_key UNIQUE (codigo_banco);
 H   ALTER TABLE ONLY public.bancos DROP CONSTRAINT bancos_codigo_banco_key;
       public                 postgres    false    232            �           2606    16804    bancos bancos_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.bancos
    ADD CONSTRAINT bancos_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.bancos DROP CONSTRAINT bancos_pkey;
       public                 postgres    false    232            �           2606    16840    beneficios beneficios_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.beneficios
    ADD CONSTRAINT beneficios_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.beneficios DROP CONSTRAINT beneficios_pkey;
       public                 postgres    false    236            �           2606    16711    familias familias_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.familias
    ADD CONSTRAINT familias_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.familias DROP CONSTRAINT familias_pkey;
       public                 postgres    false    222            �           2606    16770 $   historial_pagos historial_pagos_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.historial_pagos
    ADD CONSTRAINT historial_pagos_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.historial_pagos DROP CONSTRAINT historial_pagos_pkey;
       public                 postgres    false    228            �           2606    16718    jefe_familia jefe_familia_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.jefe_familia
    ADD CONSTRAINT jefe_familia_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.jefe_familia DROP CONSTRAINT jefe_familia_pkey;
       public                 postgres    false    224            �           2606    16900    pagos pagos_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.pagos DROP CONSTRAINT pagos_pkey;
       public                 postgres    false    238            �           2606    16819 &   referencias_pago referencias_pago_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.referencias_pago
    ADD CONSTRAINT referencias_pago_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.referencias_pago DROP CONSTRAINT referencias_pago_pkey;
       public                 postgres    false    234            �           2606    16826    roles roles_descripcion_key 
   CONSTRAINT     X   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_descripcion_key UNIQUE (nombre);
 E   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_descripcion_key;
       public                 postgres    false    218            �           2606    16679    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public                 postgres    false    218            �           2606    16782 .   usuario_familia_pago usuario_familia_pago_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.usuario_familia_pago
    ADD CONSTRAINT usuario_familia_pago_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.usuario_familia_pago DROP CONSTRAINT usuario_familia_pago_pkey;
       public                 postgres    false    230            �           2606    16732 $   usuario_familia usuario_familia_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.usuario_familia
    ADD CONSTRAINT usuario_familia_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.usuario_familia DROP CONSTRAINT usuario_familia_pkey;
       public                 postgres    false    226            �           2606    16697    usuarios usuarios_email_key 
   CONSTRAINT     X   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (correo);
 E   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_email_key;
       public                 postgres    false    220            �           2606    16693    usuarios usuarios_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public                 postgres    false    220            �           2606    16695    usuarios usuarios_username_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_username_key UNIQUE (username);
 H   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_username_key;
       public                 postgres    false    220            �           1259    16892    idx_historial_pagos_usuario    INDEX     e   CREATE INDEX idx_historial_pagos_usuario ON public.historial_pagos USING btree (usuario_familia_id);
 /   DROP INDEX public.idx_historial_pagos_usuario;
       public                 postgres    false    228            �           2620    16704 &   usuarios trigger_actualizar_updated_at    TRIGGER     �   CREATE TRIGGER trigger_actualizar_updated_at BEFORE UPDATE ON public.usuarios FOR EACH ROW EXECUTE FUNCTION public.actualizar_updated_at();
 ?   DROP TRIGGER trigger_actualizar_updated_at ON public.usuarios;
       public               postgres    false    239    220            �           2606    16807 -   historial_pagos historial_pagos_banco_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.historial_pagos
    ADD CONSTRAINT historial_pagos_banco_id_fkey FOREIGN KEY (banco_id) REFERENCES public.bancos(id);
 W   ALTER TABLE ONLY public.historial_pagos DROP CONSTRAINT historial_pagos_banco_id_fkey;
       public               postgres    false    4791    228    232            �           2606    16771 7   historial_pagos historial_pagos_usuario_familia_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.historial_pagos
    ADD CONSTRAINT historial_pagos_usuario_familia_id_fkey FOREIGN KEY (usuario_familia_id) REFERENCES public.usuario_familia(id);
 a   ALTER TABLE ONLY public.historial_pagos DROP CONSTRAINT historial_pagos_usuario_familia_id_fkey;
       public               postgres    false    228    226    4782            �           2606    16721 )   jefe_familia jefe_familia_familia_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.jefe_familia
    ADD CONSTRAINT jefe_familia_familia_id_fkey FOREIGN KEY (familia_id) REFERENCES public.familias(id);
 S   ALTER TABLE ONLY public.jefe_familia DROP CONSTRAINT jefe_familia_familia_id_fkey;
       public               postgres    false    224    4778    222            �           2606    16906    pagos pagos_banco_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_banco_id_fkey FOREIGN KEY (banco_id) REFERENCES public.bancos(id);
 C   ALTER TABLE ONLY public.pagos DROP CONSTRAINT pagos_banco_id_fkey;
       public               postgres    false    238    232    4791            �           2606    16911    pagos pagos_beneficio_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_beneficio_id_fkey FOREIGN KEY (beneficio_id) REFERENCES public.beneficios(id);
 G   ALTER TABLE ONLY public.pagos DROP CONSTRAINT pagos_beneficio_id_fkey;
       public               postgres    false    236    238    4795            �           2606    16901    pagos pagos_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);
 E   ALTER TABLE ONLY public.pagos DROP CONSTRAINT pagos_usuario_id_fkey;
       public               postgres    false    220    4774    238            �           2606    16738 /   usuario_familia usuario_familia_familia_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_familia
    ADD CONSTRAINT usuario_familia_familia_id_fkey FOREIGN KEY (familia_id) REFERENCES public.familias(id);
 Y   ALTER TABLE ONLY public.usuario_familia DROP CONSTRAINT usuario_familia_familia_id_fkey;
       public               postgres    false    226    4778    222            �           2606    16788 9   usuario_familia_pago usuario_familia_pago_familia_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_familia_pago
    ADD CONSTRAINT usuario_familia_pago_familia_id_fkey FOREIGN KEY (familia_id) REFERENCES public.familias(id);
 c   ALTER TABLE ONLY public.usuario_familia_pago DROP CONSTRAINT usuario_familia_pago_familia_id_fkey;
       public               postgres    false    230    4778    222            �           2606    16793 6   usuario_familia_pago usuario_familia_pago_pago_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_familia_pago
    ADD CONSTRAINT usuario_familia_pago_pago_id_fkey FOREIGN KEY (pago_id) REFERENCES public.historial_pagos(id);
 `   ALTER TABLE ONLY public.usuario_familia_pago DROP CONSTRAINT usuario_familia_pago_pago_id_fkey;
       public               postgres    false    230    4784    228            �           2606    16783 9   usuario_familia_pago usuario_familia_pago_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_familia_pago
    ADD CONSTRAINT usuario_familia_pago_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);
 c   ALTER TABLE ONLY public.usuario_familia_pago DROP CONSTRAINT usuario_familia_pago_usuario_id_fkey;
       public               postgres    false    230    220    4774            �           2606    16733 /   usuario_familia usuario_familia_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_familia
    ADD CONSTRAINT usuario_familia_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);
 Y   ALTER TABLE ONLY public.usuario_familia DROP CONSTRAINT usuario_familia_usuario_id_fkey;
       public               postgres    false    4774    226    220            �           2606    16698    usuarios usuarios_rol_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_rol_id_fkey FOREIGN KEY (rol_id) REFERENCES public.roles(id);
 G   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_rol_id_fkey;
       public               postgres    false    4770    220    218            k   �   x�M�=� �g�W0�b@
mGQG?��xICZ���띍qax���;��!�^�P�1��]�3��r.����}�)v�bg�L�O�9�ą�R��P	��+y,�#�B�����i|�%�<�oʳʂ���FS5��6D�#�4���DZM���N��s��E��������s�y-/P\ �@gE�      o      x�3�tO,�,�2�t�I, 2b���� ;p�      a      x������ � �      g      x������ � �      c      x������ � �      q     x�}��m1D�Ri��ys� ��RNrX&����g8K#� �A���t� N�4Z���>���RD�y��Z<���� R�&l{�Om���xZ!�J���('"�ړ(7���/� A�O�*<�wo�/�$��6b9fk�=W[!j��6��nX%DmU���ӱ�/�&b� #�Q3�-i����5۪�$�r�ݘ�M��Q�L��[��h�n�N:��!�BxV%F�Z��5���v}d��$E����'���)��ʟ��N����?^�y5      m      x������ � �      ]   5   x�3��JMK�OK����L�2�LL����2�,-.M,�̏��/�M������ T�=      e      x������ � �      i      x������ � �      _   ]  x�}��nT1��g���l�'�Y�Q��ʆM�8e�����ӓ��E��Xɟ��Ov���R.��o}�m�Ջ�_��L)�3�?=���`w��������C�A1C�9g�Ɓ���aq)%Wg���܂��1���X9[f����ZVQ�
Ѭ�:�:���k� ��a�q�Ly���˩��M=?�H��'�G8�΄����$��-�����]lO���?c%�����m˫ǯZ�����'/׵X��S�d�����p�b�!���`���IBV�lc�2�J�
sK�aD�����hp-�!�Z���AQ��<�Tn�-43Ϙ6D	4�%�_��5�<��)�b�Go�����˷��i�{��xlD�6E4̓L�^t,�eVoɫ0��U㊱P�ur�m���Z�Xj�!Ak��b�&)�y����
ұ��<89+���`��7�)	�%�����I��T����m�?&8Lǟ��;z�|^'R%�m����ט�c�.��1:D�:�p]��K�����A:�������0�"=tK=��:�R/���	w�^�U�N���x�,<Ɔ�����#٤�"L7����	��Ĥ����j��#I     