.class Lcom/aliyun/emas/apm/crash/o0;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/io/Closeable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/o0$b;,
        Lcom/aliyun/emas/apm/crash/o0$c;,
        Lcom/aliyun/emas/apm/crash/o0$d;
    }
.end annotation


# static fields
.field private static final g:Ljava/util/logging/Logger;


# instance fields
.field private final a:Ljava/io/RandomAccessFile;

.field b:I

.field private c:I

.field private d:Lcom/aliyun/emas/apm/crash/o0$b;

.field private e:Lcom/aliyun/emas/apm/crash/o0$b;

.field private final f:[B


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lcom/aliyun/emas/apm/crash/o0;

    .line 1
    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/o0;->g:Ljava/util/logging/Logger;

    return-void
.end method

.method public constructor <init>(Ljava/io/File;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0x10

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->f:[B

    .line 9
    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    .line 10
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/o0;->a(Ljava/io/File;)V

    .line 12
    :cond_0
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/o0;->b(Ljava/io/File;)Ljava/io/RandomAccessFile;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    .line 13
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/o0;->c()V

    return-void
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/crash/o0;I)I
    .locals 0

    .line 1
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/o0;->d(I)I

    move-result p0

    return p0
.end method

.method private static a([BI)I
    .locals 2

    .line 7
    aget-byte v0, p0, p1

    and-int/lit16 v0, v0, 0xff

    shl-int/lit8 v0, v0, 0x18

    add-int/lit8 v1, p1, 0x1

    aget-byte v1, p0, v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x10

    add-int/2addr v0, v1

    add-int/lit8 v1, p1, 0x2

    aget-byte v1, p0, v1

    and-int/lit16 v1, v1, 0xff

    shl-int/lit8 v1, v1, 0x8

    add-int/2addr v0, v1

    add-int/lit8 p1, p1, 0x3

    aget-byte p0, p0, p1

    and-int/lit16 p0, p0, 0xff

    add-int/2addr v0, p0

    return v0
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/crash/o0;)Ljava/io/RandomAccessFile;
    .locals 0

    .line 4
    iget-object p0, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    return-object p0
.end method

.method static synthetic a(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    .locals 0

    .line 2
    invoke-static {p0, p1}, Lcom/aliyun/emas/apm/crash/o0;->b(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method private a(I)V
    .locals 10

    add-int/lit8 p1, p1, 0x4

    .line 71
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/o0;->d()I

    move-result v0

    if-lt v0, p1, :cond_0

    return-void

    :cond_0
    iget v1, p0, Lcom/aliyun/emas/apm/crash/o0;->b:I

    :cond_1
    add-int/2addr v0, v1

    shl-int/lit8 v1, v1, 0x1

    if-lt v0, p1, :cond_1

    .line 86
    invoke-direct {p0, v1}, Lcom/aliyun/emas/apm/crash/o0;->c(I)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0;->e:Lcom/aliyun/emas/apm/crash/o0$b;

    .line 89
    iget v0, p1, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    add-int/lit8 v0, v0, 0x4

    iget p1, p1, Lcom/aliyun/emas/apm/crash/o0$b;->b:I

    add-int/2addr v0, p1

    invoke-direct {p0, v0}, Lcom/aliyun/emas/apm/crash/o0;->d(I)I

    move-result p1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->d:Lcom/aliyun/emas/apm/crash/o0$b;

    .line 92
    iget v0, v0, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    if-ge p1, v0, :cond_3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    .line 93
    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v7

    iget v0, p0, Lcom/aliyun/emas/apm/crash/o0;->b:I

    int-to-long v2, v0

    .line 94
    invoke-virtual {v7, v2, v3}, Ljava/nio/channels/FileChannel;->position(J)Ljava/nio/channels/FileChannel;

    add-int/lit8 p1, p1, -0x4

    int-to-long v8, p1

    const-wide/16 v3, 0x10

    move-object v2, v7

    move-wide v5, v8

    .line 96
    invoke-virtual/range {v2 .. v7}, Ljava/nio/channels/FileChannel;->transferTo(JJLjava/nio/channels/WritableByteChannel;)J

    move-result-wide v2

    cmp-long p1, v2, v8

    if-nez p1, :cond_2

    goto :goto_0

    .line 97
    :cond_2
    new-instance p1, Ljava/lang/AssertionError;

    const-string v0, "Copied insufficient number of bytes!"

    invoke-direct {p1, v0}, Ljava/lang/AssertionError;-><init>(Ljava/lang/Object;)V

    throw p1

    :cond_3
    :goto_0
    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0;->e:Lcom/aliyun/emas/apm/crash/o0$b;

    .line 102
    iget p1, p1, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->d:Lcom/aliyun/emas/apm/crash/o0$b;

    iget v0, v0, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    if-ge p1, v0, :cond_4

    iget v2, p0, Lcom/aliyun/emas/apm/crash/o0;->b:I

    add-int/2addr v2, p1

    add-int/lit8 v2, v2, -0x10

    iget p1, p0, Lcom/aliyun/emas/apm/crash/o0;->c:I

    .line 104
    invoke-direct {p0, v1, p1, v0, v2}, Lcom/aliyun/emas/apm/crash/o0;->a(IIII)V

    .line 105
    new-instance p1, Lcom/aliyun/emas/apm/crash/o0$b;

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->e:Lcom/aliyun/emas/apm/crash/o0$b;

    iget v0, v0, Lcom/aliyun/emas/apm/crash/o0$b;->b:I

    invoke-direct {p1, v2, v0}, Lcom/aliyun/emas/apm/crash/o0$b;-><init>(II)V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/o0;->e:Lcom/aliyun/emas/apm/crash/o0$b;

    goto :goto_1

    :cond_4
    iget v2, p0, Lcom/aliyun/emas/apm/crash/o0;->c:I

    .line 107
    invoke-direct {p0, v1, v2, v0, p1}, Lcom/aliyun/emas/apm/crash/o0;->a(IIII)V

    :goto_1
    iput v1, p0, Lcom/aliyun/emas/apm/crash/o0;->b:I

    return-void
.end method

.method private a(IIII)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->f:[B

    filled-new-array {p1, p2, p3, p4}, [I

    move-result-object p1

    .line 8
    invoke-static {v0, p1}, Lcom/aliyun/emas/apm/crash/o0;->a([B[I)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    const-wide/16 p2, 0x0

    .line 9
    invoke-virtual {p1, p2, p3}, Ljava/io/RandomAccessFile;->seek(J)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    iget-object p2, p0, Lcom/aliyun/emas/apm/crash/o0;->f:[B

    .line 10
    invoke-virtual {p1, p2}, Ljava/io/RandomAccessFile;->write([B)V

    return-void
.end method

.method private a(I[BII)V
    .locals 4

    .line 28
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/o0;->d(I)I

    move-result p1

    add-int v0, p1, p4

    iget v1, p0, Lcom/aliyun/emas/apm/crash/o0;->b:I

    if-gt v0, v1, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    int-to-long v1, p1

    .line 30
    invoke-virtual {v0, v1, v2}, Ljava/io/RandomAccessFile;->seek(J)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    .line 31
    invoke-virtual {p1, p2, p3, p4}, Ljava/io/RandomAccessFile;->readFully([BII)V

    goto :goto_0

    :cond_0
    sub-int/2addr v1, p1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    int-to-long v2, p1

    .line 36
    invoke-virtual {v0, v2, v3}, Ljava/io/RandomAccessFile;->seek(J)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    .line 37
    invoke-virtual {p1, p2, p3, v1}, Ljava/io/RandomAccessFile;->readFully([BII)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    const-wide/16 v2, 0x10

    .line 38
    invoke-virtual {p1, v2, v3}, Ljava/io/RandomAccessFile;->seek(J)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    add-int/2addr p3, v1

    sub-int/2addr p4, v1

    .line 39
    invoke-virtual {p1, p2, p3, p4}, Ljava/io/RandomAccessFile;->readFully([BII)V

    :goto_0
    return-void
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/crash/o0;I[BII)V
    .locals 0

    .line 3
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/aliyun/emas/apm/crash/o0;->a(I[BII)V

    return-void
.end method

.method private static a(Ljava/io/File;)V
    .locals 5

    .line 11
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ".tmp"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 12
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/o0;->b(Ljava/io/File;)Ljava/io/RandomAccessFile;

    move-result-object v1

    const-wide/16 v2, 0x1000

    .line 14
    :try_start_0
    invoke-virtual {v1, v2, v3}, Ljava/io/RandomAccessFile;->setLength(J)V

    const-wide/16 v2, 0x0

    .line 15
    invoke-virtual {v1, v2, v3}, Ljava/io/RandomAccessFile;->seek(J)V

    const/16 v2, 0x10

    new-array v2, v2, [B

    const/4 v3, 0x0

    const/16 v4, 0x1000

    filled-new-array {v4, v3, v3, v3}, [I

    move-result-object v3

    .line 17
    invoke-static {v2, v3}, Lcom/aliyun/emas/apm/crash/o0;->a([B[I)V

    .line 18
    invoke-virtual {v1, v2}, Ljava/io/RandomAccessFile;->write([B)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 20
    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->close()V

    .line 24
    invoke-virtual {v0, p0}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-result p0

    if-eqz p0, :cond_0

    return-void

    .line 25
    :cond_0
    new-instance p0, Ljava/io/IOException;

    const-string v0, "Rename failed!"

    invoke-direct {p0, v0}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    :catchall_0
    move-exception p0

    .line 26
    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->close()V

    .line 27
    throw p0
.end method

.method private static varargs a([B[I)V
    .locals 4

    .line 5
    array-length v0, p1

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v1, v0, :cond_0

    aget v3, p1, v1

    .line 6
    invoke-static {p0, v2, v3}, Lcom/aliyun/emas/apm/crash/o0;->b([BII)V

    add-int/lit8 v2, v2, 0x4

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method private b(I)Lcom/aliyun/emas/apm/crash/o0$b;
    .locals 3

    if-nez p1, :cond_0

    .line 5
    sget-object p1, Lcom/aliyun/emas/apm/crash/o0$b;->c:Lcom/aliyun/emas/apm/crash/o0$b;

    return-object p1

    :cond_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    int-to-long v1, p1

    .line 7
    invoke-virtual {v0, v1, v2}, Ljava/io/RandomAccessFile;->seek(J)V

    .line 8
    new-instance v0, Lcom/aliyun/emas/apm/crash/o0$b;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->readInt()I

    move-result v1

    invoke-direct {v0, p1, v1}, Lcom/aliyun/emas/apm/crash/o0$b;-><init>(II)V

    return-object v0
.end method

.method private static b(Ljava/io/File;)Ljava/io/RandomAccessFile;
    .locals 2

    .line 9
    new-instance v0, Ljava/io/RandomAccessFile;

    const-string v1, "rwd"

    invoke-direct {v0, p0, v1}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method private static b(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    .locals 0

    if-eqz p0, :cond_0

    return-object p0

    .line 23
    :cond_0
    new-instance p0, Ljava/lang/NullPointerException;

    invoke-direct {p0, p1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private b(I[BII)V
    .locals 4

    .line 10
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/o0;->d(I)I

    move-result p1

    add-int v0, p1, p4

    iget v1, p0, Lcom/aliyun/emas/apm/crash/o0;->b:I

    if-gt v0, v1, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    int-to-long v1, p1

    .line 12
    invoke-virtual {v0, v1, v2}, Ljava/io/RandomAccessFile;->seek(J)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    .line 13
    invoke-virtual {p1, p2, p3, p4}, Ljava/io/RandomAccessFile;->write([BII)V

    goto :goto_0

    :cond_0
    sub-int/2addr v1, p1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    int-to-long v2, p1

    .line 18
    invoke-virtual {v0, v2, v3}, Ljava/io/RandomAccessFile;->seek(J)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    .line 19
    invoke-virtual {p1, p2, p3, v1}, Ljava/io/RandomAccessFile;->write([BII)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    const-wide/16 v2, 0x10

    .line 20
    invoke-virtual {p1, v2, v3}, Ljava/io/RandomAccessFile;->seek(J)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    add-int/2addr p3, v1

    sub-int/2addr p4, v1

    .line 21
    invoke-virtual {p1, p2, p3, p4}, Ljava/io/RandomAccessFile;->write([BII)V

    :goto_0
    return-void
.end method

.method private static b([BII)V
    .locals 2

    shr-int/lit8 v0, p2, 0x18

    int-to-byte v0, v0

    .line 1
    aput-byte v0, p0, p1

    add-int/lit8 v0, p1, 0x1

    shr-int/lit8 v1, p2, 0x10

    int-to-byte v1, v1

    .line 2
    aput-byte v1, p0, v0

    add-int/lit8 v0, p1, 0x2

    shr-int/lit8 v1, p2, 0x8

    int-to-byte v1, v1

    .line 3
    aput-byte v1, p0, v0

    add-int/lit8 p1, p1, 0x3

    int-to-byte p2, p2

    .line 4
    aput-byte p2, p0, p1

    return-void
.end method

.method private c()V
    .locals 4

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    const-wide/16 v1, 0x0

    .line 1
    invoke-virtual {v0, v1, v2}, Ljava/io/RandomAccessFile;->seek(J)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/o0;->f:[B

    .line 2
    invoke-virtual {v0, v1}, Ljava/io/RandomAccessFile;->readFully([B)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->f:[B

    const/4 v1, 0x0

    .line 3
    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/crash/o0;->a([BI)I

    move-result v0

    iput v0, p0, Lcom/aliyun/emas/apm/crash/o0;->b:I

    int-to-long v0, v0

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    .line 4
    invoke-virtual {v2}, Ljava/io/RandomAccessFile;->length()J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-gtz v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->f:[B

    const/4 v1, 0x4

    .line 8
    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/crash/o0;->a([BI)I

    move-result v0

    iput v0, p0, Lcom/aliyun/emas/apm/crash/o0;->c:I

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->f:[B

    const/16 v1, 0x8

    .line 9
    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/crash/o0;->a([BI)I

    move-result v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/o0;->f:[B

    const/16 v2, 0xc

    .line 10
    invoke-static {v1, v2}, Lcom/aliyun/emas/apm/crash/o0;->a([BI)I

    move-result v1

    .line 11
    invoke-direct {p0, v0}, Lcom/aliyun/emas/apm/crash/o0;->b(I)Lcom/aliyun/emas/apm/crash/o0$b;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->d:Lcom/aliyun/emas/apm/crash/o0$b;

    .line 12
    invoke-direct {p0, v1}, Lcom/aliyun/emas/apm/crash/o0;->b(I)Lcom/aliyun/emas/apm/crash/o0$b;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->e:Lcom/aliyun/emas/apm/crash/o0$b;

    return-void

    .line 13
    :cond_0
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "File is truncated. Expected length: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v2, p0, Lcom/aliyun/emas/apm/crash/o0;->b:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", Actual length: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    .line 14
    invoke-virtual {v2}, Ljava/io/RandomAccessFile;->length()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private c(I)V
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    int-to-long v1, p1

    .line 15
    invoke-virtual {v0, v1, v2}, Ljava/io/RandomAccessFile;->setLength(J)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    .line 16
    invoke-virtual {p1}, Ljava/io/RandomAccessFile;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object p1

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Ljava/nio/channels/FileChannel;->force(Z)V

    return-void
.end method

.method private d()I
    .locals 2

    iget v0, p0, Lcom/aliyun/emas/apm/crash/o0;->b:I

    .line 2
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/o0;->f()I

    move-result v1

    sub-int/2addr v0, v1

    return v0
.end method

.method private d(I)I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/o0;->b:I

    if-ge p1, v0, :cond_0

    goto :goto_0

    :cond_0
    add-int/lit8 p1, p1, 0x10

    sub-int/2addr p1, v0

    :goto_0
    return p1
.end method


# virtual methods
.method public declared-synchronized a()V
    .locals 2

    monitor-enter p0

    const/4 v0, 0x0

    const/16 v1, 0x1000

    .line 116
    :try_start_0
    invoke-direct {p0, v1, v0, v0, v0}, Lcom/aliyun/emas/apm/crash/o0;->a(IIII)V

    iput v0, p0, Lcom/aliyun/emas/apm/crash/o0;->c:I

    .line 118
    sget-object v0, Lcom/aliyun/emas/apm/crash/o0$b;->c:Lcom/aliyun/emas/apm/crash/o0$b;

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->d:Lcom/aliyun/emas/apm/crash/o0$b;

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->e:Lcom/aliyun/emas/apm/crash/o0$b;

    iget v0, p0, Lcom/aliyun/emas/apm/crash/o0;->b:I

    if-le v0, v1, :cond_0

    .line 120
    invoke-direct {p0, v1}, Lcom/aliyun/emas/apm/crash/o0;->c(I)V

    :cond_0
    iput v1, p0, Lcom/aliyun/emas/apm/crash/o0;->b:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 121
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized a(Lcom/aliyun/emas/apm/crash/o0$d;)V
    .locals 4

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->d:Lcom/aliyun/emas/apm/crash/o0$b;

    .line 111
    iget v0, v0, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    const/4 v1, 0x0

    :goto_0
    iget v2, p0, Lcom/aliyun/emas/apm/crash/o0;->c:I

    if-ge v1, v2, :cond_0

    .line 113
    invoke-direct {p0, v0}, Lcom/aliyun/emas/apm/crash/o0;->b(I)Lcom/aliyun/emas/apm/crash/o0$b;

    move-result-object v0

    .line 114
    new-instance v2, Lcom/aliyun/emas/apm/crash/o0$c;

    const/4 v3, 0x0

    invoke-direct {v2, p0, v0, v3}, Lcom/aliyun/emas/apm/crash/o0$c;-><init>(Lcom/aliyun/emas/apm/crash/o0;Lcom/aliyun/emas/apm/crash/o0$b;Lcom/aliyun/emas/apm/crash/o0$a;)V

    iget v3, v0, Lcom/aliyun/emas/apm/crash/o0$b;->b:I

    invoke-interface {p1, v2, v3}, Lcom/aliyun/emas/apm/crash/o0$d;->a(Ljava/io/InputStream;I)V

    .line 115
    iget v2, v0, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    add-int/lit8 v2, v2, 0x4

    iget v0, v0, Lcom/aliyun/emas/apm/crash/o0$b;->b:I

    add-int/2addr v2, v0

    invoke-direct {p0, v2}, Lcom/aliyun/emas/apm/crash/o0;->d(I)I

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public a([B)V
    .locals 2

    .line 40
    array-length v0, p1

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lcom/aliyun/emas/apm/crash/o0;->a([BII)V

    return-void
.end method

.method public declared-synchronized a([BII)V
    .locals 6

    monitor-enter p0

    :try_start_0
    const-string v0, "buffer"

    .line 41
    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/crash/o0;->b(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    or-int v0, p2, p3

    if-ltz v0, :cond_3

    .line 42
    array-length v0, p1

    sub-int/2addr v0, p2

    if-gt p3, v0, :cond_3

    .line 46
    invoke-direct {p0, p3}, Lcom/aliyun/emas/apm/crash/o0;->a(I)V

    .line 49
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/o0;->b()Z

    move-result v0

    const/4 v1, 0x4

    if-eqz v0, :cond_0

    const/16 v2, 0x10

    goto :goto_0

    :cond_0
    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/o0;->e:Lcom/aliyun/emas/apm/crash/o0$b;

    .line 53
    iget v3, v2, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    add-int/2addr v3, v1

    iget v2, v2, Lcom/aliyun/emas/apm/crash/o0$b;->b:I

    add-int/2addr v3, v2

    invoke-direct {p0, v3}, Lcom/aliyun/emas/apm/crash/o0;->d(I)I

    move-result v2

    .line 54
    :goto_0
    new-instance v3, Lcom/aliyun/emas/apm/crash/o0$b;

    invoke-direct {v3, v2, p3}, Lcom/aliyun/emas/apm/crash/o0$b;-><init>(II)V

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/o0;->f:[B

    const/4 v4, 0x0

    .line 57
    invoke-static {v2, v4, p3}, Lcom/aliyun/emas/apm/crash/o0;->b([BII)V

    .line 58
    iget v2, v3, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    iget-object v5, p0, Lcom/aliyun/emas/apm/crash/o0;->f:[B

    invoke-direct {p0, v2, v5, v4, v1}, Lcom/aliyun/emas/apm/crash/o0;->b(I[BII)V

    .line 61
    iget v2, v3, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    add-int/2addr v2, v1

    invoke-direct {p0, v2, p1, p2, p3}, Lcom/aliyun/emas/apm/crash/o0;->b(I[BII)V

    if-eqz v0, :cond_1

    .line 64
    iget p1, v3, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0;->d:Lcom/aliyun/emas/apm/crash/o0$b;

    iget p1, p1, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    :goto_1
    iget p2, p0, Lcom/aliyun/emas/apm/crash/o0;->b:I

    iget p3, p0, Lcom/aliyun/emas/apm/crash/o0;->c:I

    add-int/lit8 p3, p3, 0x1

    .line 65
    iget v1, v3, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    invoke-direct {p0, p2, p3, p1, v1}, Lcom/aliyun/emas/apm/crash/o0;->a(IIII)V

    iput-object v3, p0, Lcom/aliyun/emas/apm/crash/o0;->e:Lcom/aliyun/emas/apm/crash/o0$b;

    iget p1, p0, Lcom/aliyun/emas/apm/crash/o0;->c:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/aliyun/emas/apm/crash/o0;->c:I

    if-eqz v0, :cond_2

    iput-object v3, p0, Lcom/aliyun/emas/apm/crash/o0;->d:Lcom/aliyun/emas/apm/crash/o0$b;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 69
    :cond_2
    monitor-exit p0

    return-void

    .line 70
    :cond_3
    :try_start_1
    new-instance p1, Ljava/lang/IndexOutOfBoundsException;

    invoke-direct {p1}, Ljava/lang/IndexOutOfBoundsException;-><init>()V

    throw p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized b()Z
    .locals 1

    monitor-enter p0

    :try_start_0
    iget v0, p0, Lcom/aliyun/emas/apm/crash/o0;->c:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 22
    :goto_0
    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized close()V
    .locals 1

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->a:Ljava/io/RandomAccessFile;

    .line 1
    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->close()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized e()V
    .locals 6

    monitor-enter p0

    .line 1
    :try_start_0
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/o0;->b()Z

    move-result v0

    if-nez v0, :cond_1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/o0;->c:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 5
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/o0;->a()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->d:Lcom/aliyun/emas/apm/crash/o0$b;

    .line 8
    iget v2, v0, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    const/4 v3, 0x4

    add-int/2addr v2, v3

    iget v0, v0, Lcom/aliyun/emas/apm/crash/o0$b;->b:I

    add-int/2addr v2, v0

    invoke-direct {p0, v2}, Lcom/aliyun/emas/apm/crash/o0;->d(I)I

    move-result v0

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/o0;->f:[B

    const/4 v4, 0x0

    .line 9
    invoke-direct {p0, v0, v2, v4, v3}, Lcom/aliyun/emas/apm/crash/o0;->a(I[BII)V

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/o0;->f:[B

    .line 10
    invoke-static {v2, v4}, Lcom/aliyun/emas/apm/crash/o0;->a([BI)I

    move-result v2

    iget v3, p0, Lcom/aliyun/emas/apm/crash/o0;->b:I

    iget v4, p0, Lcom/aliyun/emas/apm/crash/o0;->c:I

    sub-int/2addr v4, v1

    iget-object v5, p0, Lcom/aliyun/emas/apm/crash/o0;->e:Lcom/aliyun/emas/apm/crash/o0$b;

    .line 11
    iget v5, v5, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    invoke-direct {p0, v3, v4, v0, v5}, Lcom/aliyun/emas/apm/crash/o0;->a(IIII)V

    iget v3, p0, Lcom/aliyun/emas/apm/crash/o0;->c:I

    sub-int/2addr v3, v1

    iput v3, p0, Lcom/aliyun/emas/apm/crash/o0;->c:I

    .line 13
    new-instance v1, Lcom/aliyun/emas/apm/crash/o0$b;

    invoke-direct {v1, v0, v2}, Lcom/aliyun/emas/apm/crash/o0$b;-><init>(II)V

    iput-object v1, p0, Lcom/aliyun/emas/apm/crash/o0;->d:Lcom/aliyun/emas/apm/crash/o0$b;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    monitor-exit p0

    return-void

    .line 14
    :cond_1
    :try_start_1
    new-instance v0, Ljava/util/NoSuchElementException;

    invoke-direct {v0}, Ljava/util/NoSuchElementException;-><init>()V

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public f()I
    .locals 4

    iget v0, p0, Lcom/aliyun/emas/apm/crash/o0;->c:I

    const/16 v1, 0x10

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0;->e:Lcom/aliyun/emas/apm/crash/o0$b;

    .line 5
    iget v2, v0, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/o0;->d:Lcom/aliyun/emas/apm/crash/o0$b;

    iget v3, v3, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    if-lt v2, v3, :cond_1

    sub-int/2addr v2, v3

    add-int/lit8 v2, v2, 0x4

    .line 7
    iget v0, v0, Lcom/aliyun/emas/apm/crash/o0$b;->b:I

    add-int/2addr v2, v0

    add-int/2addr v2, v1

    return v2

    :cond_1
    add-int/lit8 v2, v2, 0x4

    .line 13
    iget v0, v0, Lcom/aliyun/emas/apm/crash/o0$b;->b:I

    add-int/2addr v2, v0

    iget v0, p0, Lcom/aliyun/emas/apm/crash/o0;->b:I

    add-int/2addr v2, v0

    sub-int/2addr v2, v3

    return v2
.end method

.method public toString()Ljava/lang/String;
    .locals 5

    .line 1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 2
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "[fileLength="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v1, p0, Lcom/aliyun/emas/apm/crash/o0;->b:I

    .line 3
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", size="

    .line 4
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/aliyun/emas/apm/crash/o0;->c:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, ", first="

    .line 5
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/o0;->d:Lcom/aliyun/emas/apm/crash/o0$b;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, ", last="

    .line 6
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/o0;->e:Lcom/aliyun/emas/apm/crash/o0$b;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, ", element lengths=["

    .line 7
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 9
    :try_start_0
    new-instance v1, Lcom/aliyun/emas/apm/crash/o0$a;

    invoke-direct {v1, p0, v0}, Lcom/aliyun/emas/apm/crash/o0$a;-><init>(Lcom/aliyun/emas/apm/crash/o0;Ljava/lang/StringBuilder;)V

    invoke-virtual {p0, v1}, Lcom/aliyun/emas/apm/crash/o0;->a(Lcom/aliyun/emas/apm/crash/o0$d;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    sget-object v2, Lcom/aliyun/emas/apm/crash/o0;->g:Ljava/util/logging/Logger;

    .line 24
    sget-object v3, Ljava/util/logging/Level;->WARNING:Ljava/util/logging/Level;

    const-string v4, "read error"

    invoke-virtual {v2, v3, v4, v1}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_0
    const-string v1, "]]"

    .line 26
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 27
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
