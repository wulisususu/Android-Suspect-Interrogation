.class final Lanet/channel/detect/j;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/strategy/IConnStrategy;


# instance fields
.field final synthetic a:Lanet/channel/strategy/l$e;

.field final synthetic b:Lanet/channel/strategy/ConnProtocol;


# direct methods
.method constructor <init>(Lanet/channel/strategy/l$e;Lanet/channel/strategy/ConnProtocol;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/detect/j;->a:Lanet/channel/strategy/l$e;

    iput-object p2, p0, Lanet/channel/detect/j;->b:Lanet/channel/strategy/ConnProtocol;

    .line 289
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getConnectionTimeout()I
    .locals 1

    iget-object v0, p0, Lanet/channel/detect/j;->a:Lanet/channel/strategy/l$e;

    .line 317
    iget-object v0, v0, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    iget v0, v0, Lanet/channel/strategy/l$a;->c:I

    return v0
.end method

.method public getHeartbeat()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public getIp()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanet/channel/detect/j;->a:Lanet/channel/strategy/l$e;

    .line 292
    iget-object v0, v0, Lanet/channel/strategy/l$e;->a:Ljava/lang/String;

    return-object v0
.end method

.method public getIpSource()I
    .locals 1

    const/4 v0, 0x2

    return v0
.end method

.method public getIpType()I
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public getPort()I
    .locals 1

    iget-object v0, p0, Lanet/channel/detect/j;->a:Lanet/channel/strategy/l$e;

    .line 307
    iget-object v0, v0, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    iget v0, v0, Lanet/channel/strategy/l$a;->a:I

    return v0
.end method

.method public getProtocol()Lanet/channel/strategy/ConnProtocol;
    .locals 1

    iget-object v0, p0, Lanet/channel/detect/j;->b:Lanet/channel/strategy/ConnProtocol;

    return-object v0
.end method

.method public getReadTimeout()I
    .locals 1

    iget-object v0, p0, Lanet/channel/detect/j;->a:Lanet/channel/strategy/l$e;

    .line 322
    iget-object v0, v0, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    iget v0, v0, Lanet/channel/strategy/l$a;->d:I

    return v0
.end method

.method public getRetryTimes()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method
