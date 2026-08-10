.class public Lanet/channel/request/ByteArrayEntry;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/request/BodyEntry;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lanet/channel/request/ByteArrayEntry;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private bytes:[B

.field private contentType:Ljava/lang/String;

.field private count:I

.field private offset:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 61
    new-instance v0, Lanet/channel/request/a;

    invoke-direct {v0}, Lanet/channel/request/a;-><init>()V

    sput-object v0, Lanet/channel/request/ByteArrayEntry;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lanet/channel/request/ByteArrayEntry;->offset:I

    iput v0, p0, Lanet/channel/request/ByteArrayEntry;->count:I

    const/4 v0, 0x0

    iput-object v0, p0, Lanet/channel/request/ByteArrayEntry;->contentType:Ljava/lang/String;

    return-void
.end method

.method synthetic constructor <init>(Lanet/channel/request/a;)V
    .locals 0

    .line 13
    invoke-direct {p0}, Lanet/channel/request/ByteArrayEntry;-><init>()V

    return-void
.end method

.method public constructor <init>([B)V
    .locals 2

    const/4 v0, 0x0

    .line 21
    array-length v1, p1

    invoke-direct {p0, p1, v0, v1}, Lanet/channel/request/ByteArrayEntry;-><init>([BII)V

    return-void
.end method

.method public constructor <init>([BII)V
    .locals 1

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lanet/channel/request/ByteArrayEntry;->contentType:Ljava/lang/String;

    iput-object p1, p0, Lanet/channel/request/ByteArrayEntry;->bytes:[B

    iput p2, p0, Lanet/channel/request/ByteArrayEntry;->offset:I

    iput p3, p0, Lanet/channel/request/ByteArrayEntry;->count:I

    return-void
.end method

.method static synthetic access$100(Lanet/channel/request/ByteArrayEntry;)[B
    .locals 0

    .line 13
    iget-object p0, p0, Lanet/channel/request/ByteArrayEntry;->bytes:[B

    return-object p0
.end method

.method static synthetic access$102(Lanet/channel/request/ByteArrayEntry;[B)[B
    .locals 0

    .line 13
    iput-object p1, p0, Lanet/channel/request/ByteArrayEntry;->bytes:[B

    return-object p1
.end method

.method static synthetic access$202(Lanet/channel/request/ByteArrayEntry;I)I
    .locals 0

    .line 13
    iput p1, p0, Lanet/channel/request/ByteArrayEntry;->offset:I

    return p1
.end method

.method static synthetic access$302(Lanet/channel/request/ByteArrayEntry;I)I
    .locals 0

    .line 13
    iput p1, p0, Lanet/channel/request/ByteArrayEntry;->count:I

    return p1
.end method

.method static synthetic access$402(Lanet/channel/request/ByteArrayEntry;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 13
    iput-object p1, p0, Lanet/channel/request/ByteArrayEntry;->contentType:Ljava/lang/String;

    return-object p1
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public getContentType()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanet/channel/request/ByteArrayEntry;->contentType:Ljava/lang/String;

    return-object v0
.end method

.method public setContentType(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/request/ByteArrayEntry;->contentType:Ljava/lang/String;

    return-void
.end method

.method public writeTo(Ljava/io/OutputStream;)I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    iget-object v0, p0, Lanet/channel/request/ByteArrayEntry;->bytes:[B

    iget v1, p0, Lanet/channel/request/ByteArrayEntry;->offset:I

    iget v2, p0, Lanet/channel/request/ByteArrayEntry;->count:I

    .line 43
    invoke-virtual {p1, v0, v1, v2}, Ljava/io/OutputStream;->write([BII)V

    iget p1, p0, Lanet/channel/request/ByteArrayEntry;->count:I

    return p1
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 0

    iget-object p2, p0, Lanet/channel/request/ByteArrayEntry;->bytes:[B

    .line 54
    array-length p2, p2

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object p2, p0, Lanet/channel/request/ByteArrayEntry;->bytes:[B

    .line 55
    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeByteArray([B)V

    iget p2, p0, Lanet/channel/request/ByteArrayEntry;->offset:I

    .line 56
    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    iget p2, p0, Lanet/channel/request/ByteArrayEntry;->count:I

    .line 57
    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object p2, p0, Lanet/channel/request/ByteArrayEntry;->contentType:Ljava/lang/String;

    .line 58
    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    return-void
.end method
