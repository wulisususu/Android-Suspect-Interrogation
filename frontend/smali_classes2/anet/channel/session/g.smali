.class Lanet/channel/session/g;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/RequestCb;


# instance fields
.field final synthetic a:Lanet/channel/session/f;


# direct methods
.method constructor <init>(Lanet/channel/session/f;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/session/g;->a:Lanet/channel/session/f;

    .line 172
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDataReceive(Lanet/channel/bytes/ByteArray;Z)V
    .locals 1

    iget-object v0, p0, Lanet/channel/session/g;->a:Lanet/channel/session/f;

    .line 186
    iget-object v0, v0, Lanet/channel/session/f;->b:Lanet/channel/RequestCb;

    invoke-interface {v0, p1, p2}, Lanet/channel/RequestCb;->onDataReceive(Lanet/channel/bytes/ByteArray;Z)V

    return-void
.end method

.method public onFinish(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;)V
    .locals 5

    if-gtz p1, :cond_0

    const/16 v0, -0xcc

    if-eq p1, v0, :cond_0

    iget-object v0, p0, Lanet/channel/session/g;->a:Lanet/channel/session/f;

    .line 192
    iget-object v0, v0, Lanet/channel/session/f;->d:Lanet/channel/session/d;

    new-instance v1, Lanet/channel/entity/b;

    const/4 v2, 0x0

    const-string v3, "Http connect fail"

    const/4 v4, 0x2

    invoke-direct {v1, v4, v2, v3}, Lanet/channel/entity/b;-><init>(IILjava/lang/String;)V

    invoke-static {v0, v4, v1}, Lanet/channel/session/d;->c(Lanet/channel/session/d;ILanet/channel/entity/b;)V

    :cond_0
    iget-object v0, p0, Lanet/channel/session/g;->a:Lanet/channel/session/f;

    .line 195
    iget-object v0, v0, Lanet/channel/session/f;->b:Lanet/channel/RequestCb;

    invoke-interface {v0, p1, p2, p3}, Lanet/channel/RequestCb;->onFinish(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;)V

    return-void
.end method

.method public onResponseCode(ILjava/util/Map;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;>;)V"
        }
    .end annotation

    iget-object v0, p0, Lanet/channel/session/g;->a:Lanet/channel/session/f;

    .line 175
    iget-object v0, v0, Lanet/channel/session/f;->a:Lanet/channel/request/Request;

    invoke-virtual {v0}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v0

    const-string v1, "httpStatusCode"

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    filled-new-array {v1, v2}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "awcn.HttpSession"

    const-string v3, ""

    invoke-static {v2, v3, v0, v1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lanet/channel/session/g;->a:Lanet/channel/session/f;

    .line 176
    iget-object v0, v0, Lanet/channel/session/f;->a:Lanet/channel/request/Request;

    invoke-virtual {v0}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v0

    const-string v1, "response headers"

    filled-new-array {v1, p2}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v2, v3, v0, v1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lanet/channel/session/g;->a:Lanet/channel/session/f;

    .line 178
    iget-object v0, v0, Lanet/channel/session/f;->b:Lanet/channel/RequestCb;

    invoke-interface {v0, p1, p2}, Lanet/channel/RequestCb;->onResponseCode(ILjava/util/Map;)V

    iget-object v0, p0, Lanet/channel/session/g;->a:Lanet/channel/session/f;

    .line 179
    iget-object v0, v0, Lanet/channel/session/f;->c:Lanet/channel/statist/RequestStatistic;

    invoke-static {p2}, Lanet/channel/util/HttpHelper;->parseServerRT(Ljava/util/Map;)J

    move-result-wide v1

    iput-wide v1, v0, Lanet/channel/statist/RequestStatistic;->serverRT:J

    iget-object v0, p0, Lanet/channel/session/g;->a:Lanet/channel/session/f;

    .line 180
    iget-object v0, v0, Lanet/channel/session/f;->d:Lanet/channel/session/d;

    iget-object v1, p0, Lanet/channel/session/g;->a:Lanet/channel/session/f;

    iget-object v1, v1, Lanet/channel/session/f;->a:Lanet/channel/request/Request;

    invoke-static {v0, v1, p1}, Lanet/channel/session/d;->a(Lanet/channel/session/d;Lanet/channel/request/Request;I)V

    iget-object p1, p0, Lanet/channel/session/g;->a:Lanet/channel/session/f;

    .line 181
    iget-object p1, p1, Lanet/channel/session/f;->d:Lanet/channel/session/d;

    iget-object v0, p0, Lanet/channel/session/g;->a:Lanet/channel/session/f;

    iget-object v0, v0, Lanet/channel/session/f;->a:Lanet/channel/request/Request;

    invoke-static {p1, v0, p2}, Lanet/channel/session/d;->a(Lanet/channel/session/d;Lanet/channel/request/Request;Ljava/util/Map;)V

    return-void
.end method
