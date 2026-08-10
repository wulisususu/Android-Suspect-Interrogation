.class Lanet/channel/g;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/entity/EventCb;


# instance fields
.field final synthetic a:Lanet/channel/Session;

.field final synthetic b:Lanet/channel/SessionRequest;


# direct methods
.method constructor <init>(Lanet/channel/SessionRequest;Lanet/channel/Session;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/g;->b:Lanet/channel/SessionRequest;

    iput-object p2, p0, Lanet/channel/g;->a:Lanet/channel/Session;

    .line 618
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEvent(Lanet/channel/Session;ILanet/channel/entity/b;)V
    .locals 2

    const-string p1, "eventType"

    .line 621
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p3

    filled-new-array {p1, p3}, [Ljava/lang/Object;

    move-result-object p1

    const-string p3, "awcn.SessionRequest"

    const-string v0, "Receive session event"

    const/4 v1, 0x0

    invoke-static {p3, v0, v1, p1}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 623
    new-instance p1, Lanet/channel/strategy/ConnEvent;

    invoke-direct {p1}, Lanet/channel/strategy/ConnEvent;-><init>()V

    const/16 p3, 0x200

    if-ne p2, p3, :cond_0

    const/4 p2, 0x1

    .line 625
    iput-boolean p2, p1, Lanet/channel/strategy/ConnEvent;->isSuccess:Z

    :cond_0
    iget-object p2, p0, Lanet/channel/g;->b:Lanet/channel/SessionRequest;

    .line 1060
    iget-object p2, p2, Lanet/channel/SessionRequest;->c:Lanet/channel/SessionInfo;

    if-eqz p2, :cond_1

    iget-object p2, p0, Lanet/channel/g;->b:Lanet/channel/SessionRequest;

    .line 2060
    iget-object p2, p2, Lanet/channel/SessionRequest;->c:Lanet/channel/SessionInfo;

    .line 628
    iget-boolean p2, p2, Lanet/channel/SessionInfo;->isAccs:Z

    iput-boolean p2, p1, Lanet/channel/strategy/ConnEvent;->isAccs:Z

    .line 630
    :cond_1
    invoke-static {}, Lanet/channel/strategy/StrategyCenter;->getInstance()Lanet/channel/strategy/IStrategyInstance;

    move-result-object p2

    iget-object p3, p0, Lanet/channel/g;->a:Lanet/channel/Session;

    invoke-virtual {p3}, Lanet/channel/Session;->getRealHost()Ljava/lang/String;

    move-result-object p3

    iget-object v0, p0, Lanet/channel/g;->a:Lanet/channel/Session;

    invoke-virtual {v0}, Lanet/channel/Session;->getConnStrategy()Lanet/channel/strategy/IConnStrategy;

    move-result-object v0

    invoke-interface {p2, p3, v0, p1}, Lanet/channel/strategy/IStrategyInstance;->notifyConnEvent(Ljava/lang/String;Lanet/channel/strategy/IConnStrategy;Lanet/channel/strategy/ConnEvent;)V

    return-void
.end method
