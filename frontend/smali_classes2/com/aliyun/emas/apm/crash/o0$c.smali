.class final Lcom/aliyun/emas/apm/crash/o0$c;
.super Ljava/io/InputStream;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/o0;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "c"
.end annotation


# instance fields
.field private a:I

.field private b:I

.field final synthetic c:Lcom/aliyun/emas/apm/crash/o0;


# direct methods
.method private constructor <init>(Lcom/aliyun/emas/apm/crash/o0;Lcom/aliyun/emas/apm/crash/o0$b;)V
    .locals 1

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/o0$c;->c:Lcom/aliyun/emas/apm/crash/o0;

    .line 2
    invoke-direct {p0}, Ljava/io/InputStream;-><init>()V

    .line 3
    iget v0, p2, Lcom/aliyun/emas/apm/crash/o0$b;->a:I

    add-int/lit8 v0, v0, 0x4

    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/crash/o0;->a(Lcom/aliyun/emas/apm/crash/o0;I)I

    move-result p1

    iput p1, p0, Lcom/aliyun/emas/apm/crash/o0$c;->a:I

    .line 4
    iget p1, p2, Lcom/aliyun/emas/apm/crash/o0$b;->b:I

    iput p1, p0, Lcom/aliyun/emas/apm/crash/o0$c;->b:I

    return-void
.end method

.method synthetic constructor <init>(Lcom/aliyun/emas/apm/crash/o0;Lcom/aliyun/emas/apm/crash/o0$b;Lcom/aliyun/emas/apm/crash/o0$a;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Lcom/aliyun/emas/apm/crash/o0$c;-><init>(Lcom/aliyun/emas/apm/crash/o0;Lcom/aliyun/emas/apm/crash/o0$b;)V

    return-void
.end method


# virtual methods
.method public read()I
    .locals 3

    iget v0, p0, Lcom/aliyun/emas/apm/crash/o0$c;->b:I

    if-nez v0, :cond_0

    const/4 v0, -0x1

    return v0

    :cond_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0$c;->c:Lcom/aliyun/emas/apm/crash/o0;

    .line 16
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/o0;->a(Lcom/aliyun/emas/apm/crash/o0;)Ljava/io/RandomAccessFile;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/o0$c;->a:I

    int-to-long v1, v1

    invoke-virtual {v0, v1, v2}, Ljava/io/RandomAccessFile;->seek(J)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0$c;->c:Lcom/aliyun/emas/apm/crash/o0;

    .line 17
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/o0;->a(Lcom/aliyun/emas/apm/crash/o0;)Ljava/io/RandomAccessFile;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->read()I

    move-result v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/o0$c;->c:Lcom/aliyun/emas/apm/crash/o0;

    iget v2, p0, Lcom/aliyun/emas/apm/crash/o0$c;->a:I

    add-int/lit8 v2, v2, 0x1

    .line 18
    invoke-static {v1, v2}, Lcom/aliyun/emas/apm/crash/o0;->a(Lcom/aliyun/emas/apm/crash/o0;I)I

    move-result v1

    iput v1, p0, Lcom/aliyun/emas/apm/crash/o0$c;->a:I

    iget v1, p0, Lcom/aliyun/emas/apm/crash/o0$c;->b:I

    add-int/lit8 v1, v1, -0x1

    iput v1, p0, Lcom/aliyun/emas/apm/crash/o0$c;->b:I

    return v0
.end method

.method public read([BII)I
    .locals 2

    const-string v0, "buffer"

    .line 1
    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/crash/o0;->a(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    or-int v0, p2, p3

    if-ltz v0, :cond_2

    .line 2
    array-length v0, p1

    sub-int/2addr v0, p2

    if-gt p3, v0, :cond_2

    iget v0, p0, Lcom/aliyun/emas/apm/crash/o0$c;->b:I

    if-lez v0, :cond_1

    if-le p3, v0, :cond_0

    move p3, v0

    :cond_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o0$c;->c:Lcom/aliyun/emas/apm/crash/o0;

    iget v1, p0, Lcom/aliyun/emas/apm/crash/o0$c;->a:I

    .line 9
    invoke-static {v0, v1, p1, p2, p3}, Lcom/aliyun/emas/apm/crash/o0;->a(Lcom/aliyun/emas/apm/crash/o0;I[BII)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0$c;->c:Lcom/aliyun/emas/apm/crash/o0;

    iget p2, p0, Lcom/aliyun/emas/apm/crash/o0$c;->a:I

    add-int/2addr p2, p3

    .line 10
    invoke-static {p1, p2}, Lcom/aliyun/emas/apm/crash/o0;->a(Lcom/aliyun/emas/apm/crash/o0;I)I

    move-result p1

    iput p1, p0, Lcom/aliyun/emas/apm/crash/o0$c;->a:I

    iget p1, p0, Lcom/aliyun/emas/apm/crash/o0$c;->b:I

    sub-int/2addr p1, p3

    iput p1, p0, Lcom/aliyun/emas/apm/crash/o0$c;->b:I

    return p3

    :cond_1
    const/4 p1, -0x1

    return p1

    .line 12
    :cond_2
    new-instance p1, Ljava/lang/ArrayIndexOutOfBoundsException;

    invoke-direct {p1}, Ljava/lang/ArrayIndexOutOfBoundsException;-><init>()V

    throw p1
.end method
