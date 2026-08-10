.class Lcom/aliyun/emas/apm/crash/p0$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/crash/o0$d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/p0;->d()Lcom/aliyun/emas/apm/crash/p0$b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:[B

.field final synthetic b:[I

.field final synthetic c:Lcom/aliyun/emas/apm/crash/p0;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/p0;[B[I)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/p0$a;->c:Lcom/aliyun/emas/apm/crash/p0;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/p0$a;->a:[B

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/p0$a;->b:[I

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/io/InputStream;I)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/p0$a;->a:[B

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/p0$a;->b:[I

    const/4 v2, 0x0

    .line 1
    aget v1, v1, v2

    invoke-virtual {p1, v0, v1, p2}, Ljava/io/InputStream;->read([BII)I

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/p0$a;->b:[I

    .line 2
    aget v1, v0, v2

    add-int/2addr v1, p2

    aput v1, v0, v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 4
    invoke-virtual {p1}, Ljava/io/InputStream;->close()V

    return-void

    :catchall_0
    move-exception p2

    .line 5
    invoke-virtual {p1}, Ljava/io/InputStream;->close()V

    .line 6
    throw p2
.end method
