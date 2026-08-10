.class final Lanet/channel/e/g;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/strategy/IConnStrategy;


# instance fields
.field final synthetic a:Lanet/channel/strategy/IConnStrategy;


# direct methods
.method constructor <init>(Lanet/channel/strategy/IConnStrategy;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/e/g;->a:Lanet/channel/strategy/IConnStrategy;

    .line 227
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getConnectionTimeout()I
    .locals 1

    iget-object v0, p0, Lanet/channel/e/g;->a:Lanet/channel/strategy/IConnStrategy;

    .line 257
    invoke-interface {v0}, Lanet/channel/strategy/IConnStrategy;->getConnectionTimeout()I

    move-result v0

    return v0
.end method

.method public getHeartbeat()I
    .locals 1

    iget-object v0, p0, Lanet/channel/e/g;->a:Lanet/channel/strategy/IConnStrategy;

    .line 272
    invoke-interface {v0}, Lanet/channel/strategy/IConnStrategy;->getHeartbeat()I

    move-result v0

    return v0
.end method

.method public getIp()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanet/channel/e/g;->a:Lanet/channel/strategy/IConnStrategy;

    .line 230
    invoke-interface {v0}, Lanet/channel/strategy/IConnStrategy;->getIp()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getIpSource()I
    .locals 1

    iget-object v0, p0, Lanet/channel/e/g;->a:Lanet/channel/strategy/IConnStrategy;

    .line 240
    invoke-interface {v0}, Lanet/channel/strategy/IConnStrategy;->getIpSource()I

    move-result v0

    return v0
.end method

.method public getIpType()I
    .locals 1

    iget-object v0, p0, Lanet/channel/e/g;->a:Lanet/channel/strategy/IConnStrategy;

    .line 235
    invoke-interface {v0}, Lanet/channel/strategy/IConnStrategy;->getIpType()I

    move-result v0

    return v0
.end method

.method public getPort()I
    .locals 1

    iget-object v0, p0, Lanet/channel/e/g;->a:Lanet/channel/strategy/IConnStrategy;

    .line 245
    invoke-interface {v0}, Lanet/channel/strategy/IConnStrategy;->getPort()I

    move-result v0

    return v0
.end method

.method public getProtocol()Lanet/channel/strategy/ConnProtocol;
    .locals 2

    iget-object v0, p0, Lanet/channel/e/g;->a:Lanet/channel/strategy/IConnStrategy;

    .line 250
    invoke-interface {v0}, Lanet/channel/strategy/IConnStrategy;->getProtocol()Lanet/channel/strategy/ConnProtocol;

    const-string v0, "http3_1rtt"

    const/4 v1, 0x0

    .line 252
    invoke-static {v0, v1, v1}, Lanet/channel/strategy/ConnProtocol;->valueOf(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lanet/channel/strategy/ConnProtocol;

    move-result-object v0

    return-object v0
.end method

.method public getReadTimeout()I
    .locals 1

    iget-object v0, p0, Lanet/channel/e/g;->a:Lanet/channel/strategy/IConnStrategy;

    .line 262
    invoke-interface {v0}, Lanet/channel/strategy/IConnStrategy;->getReadTimeout()I

    move-result v0

    return v0
.end method

.method public getRetryTimes()I
    .locals 1

    iget-object v0, p0, Lanet/channel/e/g;->a:Lanet/channel/strategy/IConnStrategy;

    .line 267
    invoke-interface {v0}, Lanet/channel/strategy/IConnStrategy;->getRetryTimes()I

    move-result v0

    return v0
.end method
