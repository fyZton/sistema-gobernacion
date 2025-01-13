PGDMP                       }            servicioComunitario    17.2    17.2 .    ,           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            -           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            .           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            /           1262    16387    servicioComunitario    DATABASE     �   CREATE DATABASE "servicioComunitario" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Venezuela.1252';
 %   DROP DATABASE "servicioComunitario";
                     postgres    false            �            1259    16506 	   contactos    TABLE     j  CREATE TABLE public.contactos (
    id integer NOT NULL,
    usuario_id integer,
    nombre character varying(100) NOT NULL,
    correo_electronico character varying(100) NOT NULL,
    telefono character varying(20),
    creado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    actualizado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.contactos;
       public         heap r       postgres    false            �            1259    16505    contactos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.contactos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.contactos_id_seq;
       public               postgres    false    220            0           0    0    contactos_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.contactos_id_seq OWNED BY public.contactos.id;
          public               postgres    false    219            �            1259    16522 
   pagos_clap    TABLE     �  CREATE TABLE public.pagos_clap (
    id integer NOT NULL,
    usuario_id integer,
    jefe_familia character varying(100) NOT NULL,
    cedula character varying(20) NOT NULL,
    cantidad numeric(10,2) NOT NULL,
    descripcion text NOT NULL,
    codigo_referencia character varying(50) NOT NULL,
    fecha_pago date NOT NULL,
    creado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    actualizado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.pagos_clap;
       public         heap r       postgres    false            �            1259    16521    pagos_clap_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pagos_clap_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.pagos_clap_id_seq;
       public               postgres    false    222            1           0    0    pagos_clap_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.pagos_clap_id_seq OWNED BY public.pagos_clap.id;
          public               postgres    false    221            �            1259    16538 	   pagos_gas    TABLE     �  CREATE TABLE public.pagos_gas (
    id integer NOT NULL,
    usuario_id integer,
    jefe_familia character varying(100) NOT NULL,
    cedula character varying(20) NOT NULL,
    cantidad numeric(10,2) NOT NULL,
    descripcion text NOT NULL,
    codigo_referencia character varying(50) NOT NULL,
    fecha_pago date NOT NULL,
    creado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    actualizado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.pagos_gas;
       public         heap r       postgres    false            �            1259    16537    pagos_gas_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pagos_gas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.pagos_gas_id_seq;
       public               postgres    false    224            2           0    0    pagos_gas_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.pagos_gas_id_seq OWNED BY public.pagos_gas.id;
          public               postgres    false    223            �            1259    16554    pagos_otros    TABLE     �  CREATE TABLE public.pagos_otros (
    id integer NOT NULL,
    usuario_id integer,
    jefe_familia character varying(100) NOT NULL,
    cedula character varying(20) NOT NULL,
    cantidad numeric(10,2) NOT NULL,
    descripcion text NOT NULL,
    codigo_referencia character varying(50) NOT NULL,
    fecha_pago date NOT NULL,
    creado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    actualizado_en timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.pagos_otros;
       public         heap r       postgres    false            �            1259    16553    pagos_otros_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pagos_otros_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.pagos_otros_id_seq;
       public               postgres    false    226            3           0    0    pagos_otros_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.pagos_otros_id_seq OWNED BY public.pagos_otros.id;
          public               postgres    false    225            �            1259    16491    usuarios    TABLE     �  CREATE TABLE public.usuarios (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    role character varying(20) DEFAULT 'user'::character varying
);
    DROP TABLE public.usuarios;
       public         heap r       postgres    false            �            1259    16490    usuarios_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.usuarios_id_seq;
       public               postgres    false    218            4           0    0    usuarios_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;
          public               postgres    false    217            o           2604    16509    contactos id    DEFAULT     l   ALTER TABLE ONLY public.contactos ALTER COLUMN id SET DEFAULT nextval('public.contactos_id_seq'::regclass);
 ;   ALTER TABLE public.contactos ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    220    219    220            r           2604    16525    pagos_clap id    DEFAULT     n   ALTER TABLE ONLY public.pagos_clap ALTER COLUMN id SET DEFAULT nextval('public.pagos_clap_id_seq'::regclass);
 <   ALTER TABLE public.pagos_clap ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    221    222    222            u           2604    16541    pagos_gas id    DEFAULT     l   ALTER TABLE ONLY public.pagos_gas ALTER COLUMN id SET DEFAULT nextval('public.pagos_gas_id_seq'::regclass);
 ;   ALTER TABLE public.pagos_gas ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    224    223    224            x           2604    16557    pagos_otros id    DEFAULT     p   ALTER TABLE ONLY public.pagos_otros ALTER COLUMN id SET DEFAULT nextval('public.pagos_otros_id_seq'::regclass);
 =   ALTER TABLE public.pagos_otros ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    226    225    226            k           2604    16494    usuarios id    DEFAULT     j   ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);
 :   ALTER TABLE public.usuarios ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    217    218    218            #          0    16506 	   contactos 
   TABLE DATA           t   COPY public.contactos (id, usuario_id, nombre, correo_electronico, telefono, creado_en, actualizado_en) FROM stdin;
    public               postgres    false    220   i;       %          0    16522 
   pagos_clap 
   TABLE DATA           �   COPY public.pagos_clap (id, usuario_id, jefe_familia, cedula, cantidad, descripcion, codigo_referencia, fecha_pago, creado_en, actualizado_en) FROM stdin;
    public               postgres    false    222   �;       '          0    16538 	   pagos_gas 
   TABLE DATA           �   COPY public.pagos_gas (id, usuario_id, jefe_familia, cedula, cantidad, descripcion, codigo_referencia, fecha_pago, creado_en, actualizado_en) FROM stdin;
    public               postgres    false    224   �;       )          0    16554    pagos_otros 
   TABLE DATA           �   COPY public.pagos_otros (id, usuario_id, jefe_familia, cedula, cantidad, descripcion, codigo_referencia, fecha_pago, creado_en, actualizado_en) FROM stdin;
    public               postgres    false    226   �;       !          0    16491    usuarios 
   TABLE DATA           _   COPY public.usuarios (id, username, password, email, created_at, updated_at, role) FROM stdin;
    public               postgres    false    218   �;       5           0    0    contactos_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.contactos_id_seq', 1, false);
          public               postgres    false    219            6           0    0    pagos_clap_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.pagos_clap_id_seq', 1, false);
          public               postgres    false    221            7           0    0    pagos_gas_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.pagos_gas_id_seq', 1, false);
          public               postgres    false    223            8           0    0    pagos_otros_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.pagos_otros_id_seq', 1, false);
          public               postgres    false    225            9           0    0    usuarios_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.usuarios_id_seq', 1, false);
          public               postgres    false    217            �           2606    16515 *   contactos contactos_correo_electronico_key 
   CONSTRAINT     s   ALTER TABLE ONLY public.contactos
    ADD CONSTRAINT contactos_correo_electronico_key UNIQUE (correo_electronico);
 T   ALTER TABLE ONLY public.contactos DROP CONSTRAINT contactos_correo_electronico_key;
       public                 postgres    false    220            �           2606    16513    contactos contactos_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.contactos
    ADD CONSTRAINT contactos_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.contactos DROP CONSTRAINT contactos_pkey;
       public                 postgres    false    220            �           2606    16531    pagos_clap pagos_clap_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.pagos_clap
    ADD CONSTRAINT pagos_clap_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.pagos_clap DROP CONSTRAINT pagos_clap_pkey;
       public                 postgres    false    222            �           2606    16547    pagos_gas pagos_gas_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.pagos_gas
    ADD CONSTRAINT pagos_gas_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.pagos_gas DROP CONSTRAINT pagos_gas_pkey;
       public                 postgres    false    224            �           2606    16563    pagos_otros pagos_otros_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.pagos_otros
    ADD CONSTRAINT pagos_otros_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.pagos_otros DROP CONSTRAINT pagos_otros_pkey;
       public                 postgres    false    226            |           2606    16503    usuarios usuarios_email_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);
 E   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_email_key;
       public                 postgres    false    218            ~           2606    16499    usuarios usuarios_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public                 postgres    false    218            �           2606    16501    usuarios usuarios_username_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_username_key UNIQUE (username);
 H   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_username_key;
       public                 postgres    false    218            �           2606    16516 #   contactos contactos_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.contactos
    ADD CONSTRAINT contactos_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.contactos DROP CONSTRAINT contactos_usuario_id_fkey;
       public               postgres    false    218    4734    220            �           2606    16532 %   pagos_clap pagos_clap_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pagos_clap
    ADD CONSTRAINT pagos_clap_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.pagos_clap DROP CONSTRAINT pagos_clap_usuario_id_fkey;
       public               postgres    false    4734    222    218            �           2606    16548 #   pagos_gas pagos_gas_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pagos_gas
    ADD CONSTRAINT pagos_gas_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.pagos_gas DROP CONSTRAINT pagos_gas_usuario_id_fkey;
       public               postgres    false    218    224    4734            �           2606    16564 '   pagos_otros pagos_otros_usuario_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pagos_otros
    ADD CONSTRAINT pagos_otros_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.pagos_otros DROP CONSTRAINT pagos_otros_usuario_id_fkey;
       public               postgres    false    4734    226    218            #      x������ � �      %      x������ � �      '      x������ � �      )      x������ � �      !      x������ � �     