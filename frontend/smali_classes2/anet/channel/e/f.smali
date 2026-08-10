.class Lanet/channel/e/f;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/entity/EventCb;


# instance fields
.field final synthetic a:Lanet/channel/strategy/IConnStrategy;

.field final synthetic b:Lanet/channel/e/e;


# direct methods
.method constructor <init>(Lanet/channel/e/e;Lanet/channel/strategy/IConnStrategy;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/e/f;->b:Lanet/channel/e/e;

    iput-object p2, p0, Lanet/channel/e/f;->a:Lanet/channel/strategy/IConnStrategy;

    .line 168
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEvent(Lanet/channel/Session;ILanet/channel/entity/b;)V
    .locals 2

    const/4 p3, 0x0

    const/4 v0, 0x1

    if-ne p2, v0, :cond_0

    goto :goto_0

    :cond_0
    move v0, p3

    .line 175
    :goto_0
    invoke-static {}, Lanet/channel/e/a;->f()Lanet/channel/e/a$b;

    move-result-object p2

    iget-object v1, p0, Lanet/channel/e/f;->b:Lanet/channel/e/e;

    iget-object v1, v1, Lanet/channel/e/e;->b:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    invoke-static {v1}, Lanet/channel/status/NetworkStatusHelper;->getUniqueId(Lanet/channel/status/NetworkStatusHelper$NetworkStatus;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v1, v0}, Lanet/channel/e/a$b;->a(Ljava/lang/String;Z)V

    .line 176
    invoke-virtual {p1, p3}, Lanet/channel/Session;->close(Z)V

    .line 177
    new-instance p1, Lanet/channel/statist/Http3DetectStat;

    invoke-static {}, Lanet/channel/e/a;->c()Ljava/lang/String;

    move-result-object p2

    iget-object p3, p0, Lanet/channel/e/f;->a:Lanet/channel/strategy/IConnStrategy;

    invoke-direct {p1, p2, p3}, Lanet/channel/statist/Http3DetectStat;-><init>(Ljava/lang/String;Lanet/channel/strategy/IConnStrategy;)V

    .line 178
    iput v0, p1, Lanet/channel/statist/Http3DetectStat;->ret:I

    .line 179
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p2

    invoke-interface {p2, p1}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    return-void
.end method
