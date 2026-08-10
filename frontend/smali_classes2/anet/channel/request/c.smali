.class public Lanet/channel/request/c;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/request/Cancelable;


# static fields
.field public static final NULL:Lanet/channel/request/c;


# instance fields
.field private final a:I

.field private final b:Lorg/android/spdy/SpdySession;

.field private final c:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 14
    new-instance v0, Lanet/channel/request/c;

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v1}, Lanet/channel/request/c;-><init>(Lorg/android/spdy/SpdySession;ILjava/lang/String;)V

    sput-object v0, Lanet/channel/request/c;->NULL:Lanet/channel/request/c;

    return-void
.end method

.method public constructor <init>(Lorg/android/spdy/SpdySession;ILjava/lang/String;)V
    .locals 0

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lanet/channel/request/c;->b:Lorg/android/spdy/SpdySession;

    iput p2, p0, Lanet/channel/request/c;->a:I

    iput-object p3, p0, Lanet/channel/request/c;->c:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public cancel()V
    .locals 7

    const-string v0, "awcn.TnetCancelable"

    :try_start_0
    iget-object v1, p0, Lanet/channel/request/c;->b:Lorg/android/spdy/SpdySession;

    if-eqz v1, :cond_0

    iget v1, p0, Lanet/channel/request/c;->a:I

    if-eqz v1, :cond_0

    const-string v2, "cancel tnet request"

    iget-object v3, p0, Lanet/channel/request/c;->c:Ljava/lang/String;

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const-string v5, "streamId"

    const/4 v6, 0x0

    aput-object v5, v4, v6

    .line 29
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v5, 0x1

    aput-object v1, v4, v5

    invoke-static {v0, v2, v3, v4}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v1, p0, Lanet/channel/request/c;->b:Lorg/android/spdy/SpdySession;

    iget v2, p0, Lanet/channel/request/c;->a:I

    int-to-long v2, v2

    const/4 v4, 0x5

    .line 30
    invoke-virtual {v1, v2, v3, v4}, Lorg/android/spdy/SpdySession;->streamReset(JI)I
    :try_end_0
    .catch Lorg/android/spdy/SpdyErrorException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    iget-object v2, p0, Lanet/channel/request/c;->c:Ljava/lang/String;

    .line 33
    invoke-virtual {v1}, Lorg/android/spdy/SpdyErrorException;->SpdyErrorGetCode()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    const-string v4, "errorCode"

    filled-new-array {v4, v3}, [Ljava/lang/Object;

    move-result-object v3

    const-string v4, "request cancel failed."

    invoke-static {v0, v4, v2, v1, v3}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_0
    :goto_0
    return-void
.end method
