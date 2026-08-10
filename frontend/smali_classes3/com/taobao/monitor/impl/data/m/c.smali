.class Lcom/taobao/monitor/impl/data/m/c;
.super Ljava/lang/Object;
.source "BackgroundForegroundEventImpl.java"


# instance fields
.field private final a:Lcom/taobao/application/common/IApmEventListener;

.field private final a:Lcom/taobao/application/common/data/c;

.field private final a:Lcom/taobao/application/common/data/d;

.field private final a:Ljava/lang/Runnable;

.field private a:Z

.field private final b:Ljava/lang/Runnable;


# direct methods
.method constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 7
    new-instance v0, Lcom/taobao/application/common/data/d;

    invoke-direct {v0}, Lcom/taobao/application/common/data/d;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Lcom/taobao/application/common/data/d;

    .line 8
    new-instance v0, Lcom/taobao/application/common/data/c;

    invoke-direct {v0}, Lcom/taobao/application/common/data/c;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Lcom/taobao/application/common/data/c;

    .line 11
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/IApmEventListener;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Lcom/taobao/application/common/IApmEventListener;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Z

    .line 18
    new-instance v0, Lcom/taobao/monitor/impl/data/m/c$a;

    invoke-direct {v0, p0}, Lcom/taobao/monitor/impl/data/m/c$a;-><init>(Lcom/taobao/monitor/impl/data/m/c;)V

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Ljava/lang/Runnable;

    .line 30
    new-instance v0, Lcom/taobao/monitor/impl/data/m/c$b;

    invoke-direct {v0, p0}, Lcom/taobao/monitor/impl/data/m/c$b;-><init>(Lcom/taobao/monitor/impl/data/m/c;)V

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/m/c;->b:Ljava/lang/Runnable;

    return-void
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/m/c;)Lcom/taobao/application/common/IApmEventListener;
    .locals 0

    .line 3
    iget-object p0, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Lcom/taobao/application/common/IApmEventListener;

    return-object p0
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/m/c;)Lcom/taobao/application/common/data/d;
    .locals 0

    .line 2
    iget-object p0, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Lcom/taobao/application/common/data/d;

    return-object p0
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/m/c;)Z
    .locals 0

    .line 1
    iget-boolean p0, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Z

    return p0
.end method


# virtual methods
.method a()V
    .locals 2

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Z

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Lcom/taobao/application/common/data/d;

    .line 5
    invoke-virtual {v1, v0}, Lcom/taobao/application/common/data/d;->a(Z)V

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Lcom/taobao/application/common/data/d;

    .line 6
    invoke-virtual {v1, v0}, Lcom/taobao/application/common/data/d;->b(Z)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Lcom/taobao/application/common/IApmEventListener;

    const/4 v1, 0x2

    .line 7
    invoke-interface {v0, v1}, Lcom/taobao/application/common/IApmEventListener;->onEvent(I)V

    .line 8
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/application/common/impl/b;->getAsyncHandler()Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 9
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/application/common/impl/b;->getAsyncHandler()Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/m/c;->b:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    return-void
.end method

.method b()V
    .locals 4

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Z

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Lcom/taobao/application/common/data/d;

    .line 2
    invoke-virtual {v1, v0}, Lcom/taobao/application/common/data/d;->a(Z)V

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Lcom/taobao/application/common/IApmEventListener;

    .line 3
    invoke-interface {v1, v0}, Lcom/taobao/application/common/IApmEventListener;->onEvent(I)V

    .line 5
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/application/common/impl/b;->getAsyncHandler()Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/m/c;->a:Ljava/lang/Runnable;

    const-wide/32 v2, 0x493e0

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 7
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/application/common/impl/b;->getAsyncHandler()Landroid/os/Handler;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/m/c;->b:Ljava/lang/Runnable;

    const-wide/16 v2, 0x2710

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method
