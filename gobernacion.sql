PGDMP                      }            gobernacion    17.4    17.4 e    .           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            /           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            0           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            1           1262    24578    gobernacion    DATABASE     q   CREATE DATABASE gobernacion WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es-ES';
    DROP DATABASE gobernacion;
                     postgres    false            d           1247    24580    tipo_documento_enum    TYPE     N   CREATE TYPE public.tipo_documento_enum AS ENUM (
    'V',
    'J',
    'E'
);
 &   DROP TYPE public.tipo_documento_enum;
       public               postgres    false            �            1255    24587    actualizar_updated_at()    FUNCTION     �   CREATE FUNCTION public.actualizar_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;
 .   DROP FUNCTION public.actualizar_updated_at();
       public               postgres    false            �            1259    24588    bancos    TABLE     �   CREATE TABLE public.bancos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    codigo_banco character varying(20) NOT NULL
);
    DROP TABLE public.bancos;
       public         heap r       postgres    false            �            1259    24591    bancos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bancos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.bancos_id_seq;
       public               postgres    false    217            2           0    0    bancos_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.bancos_id_seq OWNED BY public.bancos.id;
          public               postgres    false    218            �            1259    24592 
   beneficios    TABLE     �   CREATE TABLE public.beneficios (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    activo boolean DEFAULT true
);
    DROP TABLE public.beneficios;
       public         heap r       postgres    false            �            1259    24596    beneficios_id_seq    SEQUENCE     �   CREATE SEQUENCE public.beneficios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.beneficios_id_seq;
       public               postgres    false    219            3           0    0    beneficios_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.beneficios_id_seq OWNED BY public.beneficios.id;
          public               postgres    false    220            �            1259    24597    familias    TABLE     i   CREATE TABLE public.familias (
    id integer NOT NULL,
    direccion character varying(255) NOT NULL
);
    DROP TABLE public.familias;
       public         heap r       postgres    false            �            1259    24600    familias_id_seq    SEQUENCE     �   CREATE SEQUENCE public.familias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.familias_id_seq;
       public               postgres    false    221            4           0    0    familias_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.familias_id_seq OWNED BY public.familias.id;
          public               postgres    false    222            �            1259    24601    historial_pagos    TABLE     �   CREATE TABLE public.historial_pagos (
    id integer NOT NULL,
    usuario_familia_id integer NOT NULL,
    monto numeric(10,2) NOT NULL,
    fecha_pago date DEFAULT CURRENT_DATE,
    banco_id integer
);
 #   DROP TABLE public.historial_pagos;
       public         heap r       postgres    false            �            1259    24605    historial_pagos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.historial_pagos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.historial_pagos_id_seq;
       public               postgres    false    223            5           0    0    historial_pagos_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.historial_pagos_id_seq OWNED BY public.historial_pagos.id;
          public               postgres    false    224            �            1259    24606    jefe_familia    TABLE     �   CREATE TABLE public.jefe_familia (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    familia_id integer NOT NULL
);
     DROP TABLE public.jefe_familia;
       public         heap r       postgres    false            �            1259    24609    jefe_familia_id_seq    SEQUENCE     �   CREATE SEQUENCE public.jefe_familia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.jefe_familia_id_seq;
       public               postgres    false    225            6           0    0    jefe_familia_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.jefe_familia_id_seq OWNED BY public.jefe_familia.id;
          public               postgres    false    226            �            1259    24610    pagos    TABLE     &  CREATE TABLE public.pagos (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    monto numeric(10,2) NOT NULL,
    banco_id integer NOT NULL,
    beneficio_id integer NOT NULL,
    fecha timestamp without time zone DEFAULT now() NOT NULL,
    codigo_referencia character varying(6)
);
    DROP TABLE public.pagos;
       public         heap r       postgres    false            �            1259    24614    pagos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pagos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.pagos_id_seq;
       public               postgres    false    227            7           0    0    pagos_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.pagos_id_seq OWNED BY public.pagos.id;
          public               postgres    false    228            �            1259    24615    referencias_pago    TABLE     �   CREATE TABLE public.referencias_pago (
    id integer NOT NULL,
    pago_id integer NOT NULL,
    referencia_pago character varying(100) NOT NULL,
    tipo_pago character varying(50) NOT NULL,
    fecha_pago date DEFAULT CURRENT_DATE
);
 $   DROP TABLE public.referencias_pago;
       public         heap r       postgres    false            �            1259    24619    referencias_pago_id_seq    SEQUENCE     �   CREATE SEQUENCE public.referencias_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.referencias_pago_id_seq;
       public               postgres    false    229            8           0    0    referencias_pago_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.referencias_pago_id_seq OWNED BY public.referencias_pago.id;
          public               postgres    false    230            �            1259    24620    roles    TABLE     b   CREATE TABLE public.roles (
    id integer NOT NULL,
    nombre character varying(20) NOT NULL
);
    DROP TABLE public.roles;
       public         heap r       postgres    false            �            1259    24623    roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public               postgres    false    231            9           0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
          public               postgres    false    232            �            1259    24624    usuario_familia    TABLE     �   CREATE TABLE public.usuario_familia (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    familia_id integer NOT NULL
);
 #   DROP TABLE public.usuario_familia;
       public         heap r       postgres    false            �            1259    24627    usuario_familia_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_familia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.usuario_familia_id_seq;
       public               postgres    false    233            :           0    0    usuario_familia_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.usuario_familia_id_seq OWNED BY public.usuario_familia.id;
          public               postgres    false    234            �            1259    24628    usuario_familia_pago    TABLE     �   CREATE TABLE public.usuario_familia_pago (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    familia_id integer NOT NULL,
    pago_id integer NOT NULL
);
 (   DROP TABLE public.usuario_familia_pago;
       public         heap r       postgres    false            �            1259    24631    usuario_familia_pago_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_familia_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.usuario_familia_pago_id_seq;
       public               postgres    false    235            ;           0    0    usuario_familia_pago_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.usuario_familia_pago_id_seq OWNED BY public.usuario_familia_pago.id;
          public               postgres    false    236            �            1259    24632    usuarios    TABLE     �  CREATE TABLE public.usuarios (
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
    CONSTRAINT usuarios_tipo_cedula_check CHECK (((tipo_cedula)::text = ANY (ARRAY[('V'::character varying)::text, ('J'::character varying)::text, ('E'::character varying)::text])))
);
    DROP TABLE public.usuarios;
       public         heap r       postgres    false            �            1259    24640    usuarios_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.usuarios_id_seq;
       public               postgres    false    237            <           0    0    usuarios_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;
          public               postgres    false    238            G           2604    24641 	   bancos id    DEFAULT     f   ALTER TABLE ONLY public.bancos ALTER COLUMN id SET DEFAULT nextval('public.bancos_id_seq'::regclass);
 8   ALTER TABLE public.bancos ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    218    217            H           2604    24642    beneficios id    DEFAULT     n   ALTER TABLE ONLY public.beneficios ALTER COLUMN id SET DEFAULT nextval('public.beneficios_id_seq'::regclass);
 <   ALTER TABLE public.beneficios ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    220    219            J           2604    24643    familias id    DEFAULT     j   ALTER TABLE ONLY public.familias ALTER COLUMN id SET DEFAULT nextval('public.familias_id_seq'::regclass);
 :   ALTER TABLE public.familias ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221            K           2604    24644    historial_pagos id    DEFAULT     x   ALTER TABLE ONLY public.historial_pagos ALTER COLUMN id SET DEFAULT nextval('public.historial_pagos_id_seq'::regclass);
 A   ALTER TABLE public.historial_pagos ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    224    223            M           2604    24645    jefe_familia id    DEFAULT     r   ALTER TABLE ONLY public.jefe_familia ALTER COLUMN id SET DEFAULT nextval('public.jefe_familia_id_seq'::regclass);
 >   ALTER TABLE public.jefe_familia ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    226    225            N           2604    24646    pagos id    DEFAULT     d   ALTER TABLE ONLY public.pagos ALTER COLUMN id SET DEFAULT nextval('public.pagos_id_seq'::regclass);
 7   ALTER TABLE public.pagos ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    228    227            P           2604    24647    referencias_pago id    DEFAULT     z   ALTER TABLE ONLY public.referencias_pago ALTER COLUMN id SET DEFAULT nextval('public.referencias_pago_id_seq'::regclass);
 B   ALTER TABLE public.referencias_pago ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    230    229            R           2604    24648    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    232    231            S           2604    24649    usuario_familia id    DEFAULT     x   ALTER TABLE ONLY public.usuario_familia ALTER COLUMN id SET DEFAULT nextval('public.usuario_familia_id_seq'::regclass);
 A   ALTER TABLE public.usuario_familia ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    234    233            T           2604    24650    usuario_familia_pago id    DEFAULT     �   ALTER TABLE ONLY public.usuario_familia_pago ALTER COLUMN id SET DEFAULT nextval('public.usuario_familia_pago_id_seq'::regclass);
 F   ALTER TABLE public.usuario_familia_pago ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    236    235            U           2604    24651    usuarios id    DEFAULT     j   ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);
 :   ALTER TABLE public.usuarios ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    238    237                      0    24588    bancos 
   TABLE DATA           :   COPY public.bancos (id, nombre, codigo_banco) FROM stdin;
    public               postgres    false    217   ,z                 0    24592 
   beneficios 
   TABLE DATA           8   COPY public.beneficios (id, nombre, activo) FROM stdin;
    public               postgres    false    219   �z                 0    24597    familias 
   TABLE DATA           1   COPY public.familias (id, direccion) FROM stdin;
    public               postgres    false    221   #{                 0    24601    historial_pagos 
   TABLE DATA           ^   COPY public.historial_pagos (id, usuario_familia_id, monto, fecha_pago, banco_id) FROM stdin;
    public               postgres    false    223   @{                 0    24606    jefe_familia 
   TABLE DATA           >   COPY public.jefe_familia (id, nombre, familia_id) FROM stdin;
    public               postgres    false    225   ]{                  0    24610    pagos 
   TABLE DATA           h   COPY public.pagos (id, usuario_id, monto, banco_id, beneficio_id, fecha, codigo_referencia) FROM stdin;
    public               postgres    false    227   z{       "          0    24615    referencias_pago 
   TABLE DATA           _   COPY public.referencias_pago (id, pago_id, referencia_pago, tipo_pago, fecha_pago) FROM stdin;
    public               postgres    false    229   �|       $          0    24620    roles 
   TABLE DATA           +   COPY public.roles (id, nombre) FROM stdin;
    public               postgres    false    231   �|       &          0    24624    usuario_familia 
   TABLE DATA           E   COPY public.usuario_familia (id, usuario_id, familia_id) FROM stdin;
    public               postgres    false    233   K}       (          0    24628    usuario_familia_pago 
   TABLE DATA           S   COPY public.usuario_familia_pago (id, usuario_id, familia_id, pago_id) FROM stdin;
    public               postgres    false    235   h}       *          0    24632    usuarios 
   TABLE DATA           �   COPY public.usuarios (id, username, password, correo, created_at, updated_at, rol_id, nombre, apellido, tipo_cedula, numero_cedula) FROM stdin;
    public               postgres    false    237   �}       =           0    0    bancos_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.bancos_id_seq', 10, true);
          public               postgres    false    218            >           0    0    beneficios_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.beneficios_id_seq', 2, true);
          public               postgres    false    220            ?           0    0    familias_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.familias_id_seq', 1, false);
          public               postgres    false    222            @           0    0    historial_pagos_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.historial_pagos_id_seq', 1, false);
          public               postgres    false    224            A           0    0    jefe_familia_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.jefe_familia_id_seq', 3, true);
          public               postgres    false    226            B           0    0    pagos_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.pagos_id_seq', 14, true);
          public               postgres    false    228            C           0    0    referencias_pago_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.referencias_pago_id_seq', 1, false);
          public               postgres    false    230            D           0    0    roles_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.roles_id_seq', 6, true);
          public               postgres    false    232            E           0    0    usuario_familia_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.usuario_familia_id_seq', 1, false);
          public               postgres    false    234            F           0    0    usuario_familia_pago_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.usuario_familia_pago_id_seq', 1, false);
          public               postgres    false    236            G           0    0    usuarios_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.usuarios_id_seq', 15, true);
          public               postgres    false    238            Z           2606    24653    bancos bancos_codigo_banco_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.bancos
    ADD CONSTRAINT bancos_codigo_banco_key UNIQUE (codigo_banco);
 H   ALTER TABLE ONLY public.bancos DROP CONSTRAINT bancos_codigo_banco_key;
       public                 postgres    false    217            \           2606    24655    bancos bancos_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.bancos
    ADD CONSTRAINT bancos_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.bancos DROP CONSTRAINT bancos_pkey;
       public                 postgres    false    217            ^           2606    24657    beneficios beneficios_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.beneficios
    ADD CONSTRAINT beneficios_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.beneficios DROP CONSTRAINT beneficios_pkey;
       public                 postgres    false    219            `           2606    24659    familias familias_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.familias
    ADD CONSTRAINT familias_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.familias DROP CONSTRAINT familias_pkey;
       public                 postgres    false    221            b           2606    24661 $   historial_pagos historial_pagos_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.historial_pagos
    ADD CONSTRAINT historial_pagos_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.historial_pagos DROP CONSTRAINT historial_pagos_pkey;
       public                 postgres    false    223            e           2606    24663    jefe_familia jefe_familia_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.jefe_familia
    ADD CONSTRAINT jefe_familia_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.jefe_familia DROP CONSTRAINT jefe_familia_pkey;
       public                 postgres    false    225            g           2606    24665    pagos pagos_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.pagos DROP CONSTRAINT pagos_pkey;
       public                 postgres    false    227            i           2606    24667 &   referencias_pago referencias_pago_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.referencias_pago
    ADD CONSTRAINT referencias_pago_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.referencias_pago DROP CONSTRAINT referencias_pago_pkey;
       public                 postgres    false    229            k           2606    24669    roles roles_descripcion_key 
   CONSTRAINT     X   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_descripcion_key UNIQUE (nombre);
 E   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_descripcion_key;
       public                 postgres    false    231            m           2606    24671    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public                 postgres    false    231            q           2606    24673 .   usuario_familia_pago usuario_familia_pago_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.usuario_familia_pago
    ADD CONSTRAINT usuario_familia_pago_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.usuario_familia_pago DROP CONSTRAINT usuario_familia_pago_pkey;
       public                 postgres    false    235            o           2606    24675 $   usuario_familia usuario_familia_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.usuario_familia
    ADD CONSTRAINT usuario_familia_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.usuario_familia DROP CONSTRAINT usuario_familia_pkey;
       public                 postgres    false    233            s           2606    24677    usuarios usuarios_email_key 
   CONSTRAINT     X   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (correo);
 E   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_email_key;
       public                 postgres    false    237            u           2606    24679    usuarios usuarios_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public                 postgres    false    237            w           2606    24681    usuarios usuarios_username_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_username_key UNIQUE (username);
 H   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_username_key;
       public                 postgres    false    237            c           1259    24682    idx_historial_pagos_usuario    INDEX     e   CREATE INDEX idx_historial_pagos_usuario ON public.historial_pagos USING btree (usuario_familia_id);
 /   DROP INDEX public.idx_historial_pagos_usuario;
       public                 postgres    false    223            �           2620    24683 &   usuarios trigger_actualizar_updated_at    TRIGGER     �   CREATE TRIGGER trigger_actualizar_updated_at BEFORE UPDATE ON public.usuarios FOR EACH ROW EXECUTE FUNCTION public.actualizar_updated_at();
 ?   DROP TRIGGER trigger_actualizar_updated_at ON public.usuarios;
       public               postgres    false    239    237            x           2606    24684 -   historial_pagos historial_pagos_banco_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.historial_pagos
    ADD CONSTRAINT historial_pagos_banco_id_fkey FOREIGN KEY (banco_id) REFERENCES public.bancos(id);
 W   ALTER TABLE ONLY public.historial_pagos DROP CONSTRAINT historial_pagos_banco_id_fkey;
       public               postgres    false    223    4700    217            y           2606    24689 7   historial_pagos historial_pagos_usuario_familia_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.historial_pagos
    ADD CONSTRAINT historial_pagos_usuario_familia_id_fkey FOREIGN KEY (usuario_familia_id) REFERENCES public.usuario_familia(id);
 a   ALTER TABLE ONLY public.historial_pagos DROP CONSTRAINT historial_pagos_usuario_familia_id_fkey;
       public               postgres    false    4719    223    233            z           2606    24694 )   jefe_familia jefe_familia_familia_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.jefe_familia
    ADD CONSTRAINT jefe_familia_familia_id_fkey FOREIGN KEY (familia_id) REFERENCES public.familias(id);
 S   ALTER TABLE ONLY public.jefe_familia DROP CONSTRAINT jefe_familia_familia_id_fkey;
       public               postgres    false    225    221    4704            {           2606    24699    pagos pagos_banco_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_banco_id_fkey FOREIGN KEY (banco_id) REFERENCES public.bancos(id);
 C   ALTER TABLE ONLY public.pagos DROP CONSTRAINT pagos_banco_id_fkey;
       public               postgres    false    227    217    4700            |           2606    24704    pagos pagos_beneficio_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_beneficio_id_fkey FOREIGN KEY (beneficio_id) REFERENCES public.beneficios(id);
 G   ALTER TABLE ONLY public.pagos DROP CONSTRAINT pagos_beneficio_id_fkey;
       public               postgres    false    219    227    4702            }           2606    24709    pagos pagos_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);
 E   ALTER TABLE ONLY public.pagos DROP CONSTRAINT pagos_usuario_id_fkey;
       public               postgres    false    227    4725    237            ~           2606    24714 /   usuario_familia usuario_familia_familia_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_familia
    ADD CONSTRAINT usuario_familia_familia_id_fkey FOREIGN KEY (familia_id) REFERENCES public.familias(id);
 Y   ALTER TABLE ONLY public.usuario_familia DROP CONSTRAINT usuario_familia_familia_id_fkey;
       public               postgres    false    233    4704    221            �           2606    24719 9   usuario_familia_pago usuario_familia_pago_familia_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_familia_pago
    ADD CONSTRAINT usuario_familia_pago_familia_id_fkey FOREIGN KEY (familia_id) REFERENCES public.familias(id);
 c   ALTER TABLE ONLY public.usuario_familia_pago DROP CONSTRAINT usuario_familia_pago_familia_id_fkey;
       public               postgres    false    235    221    4704            �           2606    24724 6   usuario_familia_pago usuario_familia_pago_pago_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_familia_pago
    ADD CONSTRAINT usuario_familia_pago_pago_id_fkey FOREIGN KEY (pago_id) REFERENCES public.historial_pagos(id);
 `   ALTER TABLE ONLY public.usuario_familia_pago DROP CONSTRAINT usuario_familia_pago_pago_id_fkey;
       public               postgres    false    4706    223    235            �           2606    24729 9   usuario_familia_pago usuario_familia_pago_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_familia_pago
    ADD CONSTRAINT usuario_familia_pago_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);
 c   ALTER TABLE ONLY public.usuario_familia_pago DROP CONSTRAINT usuario_familia_pago_usuario_id_fkey;
       public               postgres    false    4725    237    235                       2606    24734 /   usuario_familia usuario_familia_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_familia
    ADD CONSTRAINT usuario_familia_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);
 Y   ALTER TABLE ONLY public.usuario_familia DROP CONSTRAINT usuario_familia_usuario_id_fkey;
       public               postgres    false    4725    233    237            �           2606    24739    usuarios usuarios_rol_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_rol_id_fkey FOREIGN KEY (rol_id) REFERENCES public.roles(id);
 G   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_rol_id_fkey;
       public               postgres    false    4717    237    231               �   x�M�=� �g�W0�b@
mGQG?��xICZ���띍qax���;��!�^�P�1��]�3��r.����}�)v�bg�L�O�9�ą�R��P	��+y,�#�B�����i|�%�<�oʳʂ���FS5��6D�#�4���DZM���N��s��E��������s�y-/P\ �@gE�            x�3�tO,�,�2�t�I, 2b���� ;p�            x������ � �            x������ � �            x������ � �            x�}��m1D�Ri��ys� ��RNrX&����g8K#� �A���t� N�4Z���>���RD�y��Z<���� R�&l{�Om���xZ!�J���('"�ړ(7���/� A�O�*<�wo�/�$��6b9fk�=W[!j��6��nX%DmU���ӱ�/�&b� #�Q3�-i����5۪�$�r�ݘ�M��Q�L��[��h�n�N:��!�BxV%F�Z��5���v}d��$E����'���)��ʟ��N����?^�y5      "      x������ � �      $   y   x�%�[�0D�o{1���^�*�:`���I�~B�;W3ޜxN�J�	hYE� �4r�Y�W�x��,n�����>C��x�'��k?l2x�hZ��Qa�I˃<�
@��i��0L��:o��"~�p2D      &      x������ � �      (      x������ � �      *     x�}��V���[O��n�U�}�N<�8Lƞ����fj�l@6Xv��S=��	�V�F%uW}���$��zW�6�_���tݮn>|Z3Ő�i���/>��p�rG���/gK�^%@�y䜭U��W,���f\������12��#	'�5���RהjN��ZG�!�%cҚ��$�F���ø�<��Ňs;�����b" }����ZӚp�0��O�v�����_mNwv;�~쯅N������4v?��so���_����l�
�;h��@���Jc�^1��C�(5qN*9����;�j5H��@C�q`�BP)0�kI,��5Q�Pr��C����G4hͼƸ"���S!�Z���G��gJ�X��7o�����_v�ghiF�C-t�A��=!֔���Q���=s��)S��:7�Bk�'����Pj�Y(M�Cл*��5�ZmHT]Z�G1�#��Ӌ�9��5�*��
݋�>�瓉4+*�a*�bs�������Wϟ�}����2��q�z�
Z"�2pٴ���!�4ؼ�b\��04;��-�Z
��B<.�Ƒk�d ��Uy��_ŻD�� ����ZqL�����"]Eg�}�w�	�ECL��t[�겴��;H>��g�Ώ��o�����ۥDe�0R(�鐲@���L.��s�,�$.I��0�5�*�]��u��(�Cn)D"o�ⴌ�(�����OH��(�a?�ý��	@^��5��{\ЧB�'�kuw,���M�ڞ����MO��7ȏ��ᅄ�t����
F�sXr.)�D�eh�����es-tw�Y8���AB��}t���]��������cw��:46��-�ï�=B�� a�y��Oy*�{�[�Ly>x��`��ߜ\n���z��o.�,���\:�J}0�E[.VKMF�T�/Э$���k��N��Dh	��mqٕҥ��-�C���Qq#�>~�quC���C����QOy�� ���a�\�)=��{ݟO�4������ry����G��oɧN|��ǎϕ��U�y�"$J>#�@V�YE�6&��v����7�{p���I�eeEƬ���丹bi���'V�Y͕�MW�r�����՟���WאW>��S!�+��j��?��ӵ]���yw����~==�W�xs�t���޳������EM0A��d�&��w���°���%w����b�ػ�&��H>t��;�w_e����[������z���C���F!Y� ���Ba��Ńh~_-������     