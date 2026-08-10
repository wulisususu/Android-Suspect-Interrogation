.class Lanet/channel/strategy/i;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lanet/channel/strategy/g;


# direct methods
.method constructor <init>(Lanet/channel/strategy/g;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/strategy/i;->a:Lanet/channel/strategy/g;

    .line 313
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lanet/channel/strategy/i;->a:Lanet/channel/strategy/g;

    .line 316
    invoke-static {v0}, Lanet/channel/strategy/g;->a(Lanet/channel/strategy/g;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lanet/channel/strategy/i;->a:Lanet/channel/strategy/g;

    .line 317
    iget-object v0, v0, Lanet/channel/strategy/g;->b:Lanet/channel/strategy/StrategyInfoHolder;

    invoke-virtual {v0}, Lanet/channel/strategy/StrategyInfoHolder;->c()V

    :cond_0
    return-void
.end method
