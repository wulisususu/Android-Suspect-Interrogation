.class Lanet/channel/strategy/e;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lanet/channel/strategy/StrategyInfoHolder;


# direct methods
.method constructor <init>(Lanet/channel/strategy/StrategyInfoHolder;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/strategy/e;->b:Lanet/channel/strategy/StrategyInfoHolder;

    iput-object p2, p0, Lanet/channel/strategy/e;->a:Ljava/lang/String;

    .line 248
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lanet/channel/strategy/e;->b:Lanet/channel/strategy/StrategyInfoHolder;

    iget-object v1, p0, Lanet/channel/strategy/e;->a:Ljava/lang/String;

    const/4 v2, 0x1

    .line 251
    invoke-virtual {v0, v1, v2}, Lanet/channel/strategy/StrategyInfoHolder;->a(Ljava/lang/String;Z)V

    return-void
.end method
