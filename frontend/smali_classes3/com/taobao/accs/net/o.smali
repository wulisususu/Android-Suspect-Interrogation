.class Lcom/taobao/accs/net/o;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:I

.field final synthetic b:I

.field final synthetic c:[B

.field final synthetic d:Lanet/channel/session/TnetSpdySession;

.field final synthetic e:Lcom/taobao/accs/net/j;


# direct methods
.method constructor <init>(Lcom/taobao/accs/net/j;II[BLanet/channel/session/TnetSpdySession;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/net/o;->e:Lcom/taobao/accs/net/j;

    iput p2, p0, Lcom/taobao/accs/net/o;->a:I

    iput p3, p0, Lcom/taobao/accs/net/o;->b:I

    iput-object p4, p0, Lcom/taobao/accs/net/o;->c:[B

    iput-object p5, p0, Lcom/taobao/accs/net/o;->d:Lanet/channel/session/TnetSpdySession;

    .line 404
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    iget-object v0, p0, Lcom/taobao/accs/net/o;->e:Lcom/taobao/accs/net/j;

    .line 407
    invoke-static {v0}, Lcom/taobao/accs/net/j;->a(Lcom/taobao/accs/net/j;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v0

    iget v1, p0, Lcom/taobao/accs/net/o;->a:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    iget v2, p0, Lcom/taobao/accs/net/o;->b:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "onDataReceive"

    const-string v4, "type"

    const-string v5, "dataId"

    filled-new-array {v3, v4, v1, v5, v2}, [Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    .line 409
    invoke-static {}, Lcom/taobao/accs/AccsState;->getInstance()Lcom/taobao/accs/AccsState;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/accs/net/o;->e:Lcom/taobao/accs/net/j;

    iget-object v1, v1, Lcom/taobao/accs/net/j;->m:Ljava/lang/String;

    iget v2, p0, Lcom/taobao/accs/net/o;->b:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v4, "lmrt"

    invoke-virtual {v0, v1, v4, v2}, Lcom/taobao/accs/AccsState;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    iget v0, p0, Lcom/taobao/accs/net/o;->a:I

    const/16 v1, 0xc8

    if-ne v0, v1, :cond_1

    .line 412
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object v2, p0, Lcom/taobao/accs/net/o;->e:Lcom/taobao/accs/net/j;

    .line 413
    iget-object v2, v2, Lcom/taobao/accs/net/j;->e:Lcom/taobao/accs/data/d;

    iget-object v4, p0, Lcom/taobao/accs/net/o;->c:[B

    iget-object v5, p0, Lcom/taobao/accs/net/o;->d:Lanet/channel/session/TnetSpdySession;

    invoke-virtual {v5}, Lanet/channel/session/TnetSpdySession;->getHost()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v4, v5}, Lcom/taobao/accs/data/d;->a([BLjava/lang/String;)V

    iget-object v2, p0, Lcom/taobao/accs/net/o;->e:Lcom/taobao/accs/net/j;

    .line 414
    iget-object v2, v2, Lcom/taobao/accs/net/j;->e:Lcom/taobao/accs/data/d;

    invoke-virtual {v2}, Lcom/taobao/accs/data/d;->g()Lcom/taobao/accs/ut/a/d;

    move-result-object v2

    if-eqz v2, :cond_2

    .line 416
    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v2, Lcom/taobao/accs/ut/a/d;->c:Ljava/lang/String;

    iget-object v0, p0, Lcom/taobao/accs/net/o;->e:Lcom/taobao/accs/net/j;

    .line 417
    iget v0, v0, Lcom/taobao/accs/net/j;->c:I

    if-nez v0, :cond_0

    const-string v0, "service"

    goto :goto_0

    :cond_0
    const-string v0, "inapp"

    :goto_0
    iput-object v0, v2, Lcom/taobao/accs/ut/a/d;->g:Ljava/lang/String;

    .line 419
    invoke-virtual {v2}, Lcom/taobao/accs/ut/a/d;->a()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    iget-object v1, p0, Lcom/taobao/accs/net/o;->e:Lcom/taobao/accs/net/j;

    .line 422
    invoke-static {v1}, Lcom/taobao/accs/net/j;->a(Lcom/taobao/accs/net/j;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v1

    invoke-interface {v1, v3, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 423
    invoke-static {}, Lcom/taobao/accs/utl/UTMini;->getInstance()Lcom/taobao/accs/utl/UTMini;

    move-result-object v1

    const-string v2, "DATA_RECEIVE"

    .line 424
    invoke-static {v0}, Lcom/taobao/accs/utl/UtilityImpl;->a(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v0

    const v3, 0x101d1

    .line 423
    invoke-virtual {v1, v3, v2, v0}, Lcom/taobao/accs/utl/UTMini;->commitEvent(ILjava/lang/String;Ljava/lang/Object;)V

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lcom/taobao/accs/net/o;->e:Lcom/taobao/accs/net/j;

    .line 427
    invoke-static {v0}, Lcom/taobao/accs/net/j;->a(Lcom/taobao/accs/net/j;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "drop frame len:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/taobao/accs/net/o;->c:[B

    array-length v2, v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " frameType"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p0, Lcom/taobao/accs/net/o;->a:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    :cond_2
    :goto_1
    return-void
.end method
