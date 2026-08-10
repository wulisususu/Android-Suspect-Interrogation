.class Lcom/taobao/monitor/impl/processor/b/a$b;
.super Ljava/lang/Object;
.source "WeexApmAdapterFactory.java"

# interfaces
.implements Lcom/taobao/monitor/performance/IWXApmAdapter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/impl/processor/b/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "b"
.end annotation


# instance fields
.field private final a:Lcom/taobao/monitor/performance/IWXApmAdapter;


# direct methods
.method private constructor <init>(Lcom/taobao/monitor/performance/IWXApmAdapter;)V
    .locals 0

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/b/a$b;->a:Lcom/taobao/monitor/performance/IWXApmAdapter;

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/monitor/performance/IWXApmAdapter;Lcom/taobao/monitor/impl/processor/b/a$a;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1}, Lcom/taobao/monitor/impl/processor/b/a$b;-><init>(Lcom/taobao/monitor/performance/IWXApmAdapter;)V

    return-void
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/processor/b/a$b;)Lcom/taobao/monitor/performance/IWXApmAdapter;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/taobao/monitor/impl/processor/b/a$b;->a:Lcom/taobao/monitor/performance/IWXApmAdapter;

    return-object p0
.end method

.method private a(Ljava/lang/Runnable;)V
    .locals 1

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method


# virtual methods
.method public addBiz(Ljava/lang/String;Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/processor/b/a$b$i;

    invoke-direct {v0, p0, p1, p2}, Lcom/taobao/monitor/impl/processor/b/a$b$i;-><init>(Lcom/taobao/monitor/impl/processor/b/a$b;Ljava/lang/String;Ljava/util/Map;)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/b/a$b;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public addBizAbTest(Ljava/lang/String;Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/processor/b/a$b$j;

    invoke-direct {v0, p0, p1, p2}, Lcom/taobao/monitor/impl/processor/b/a$b$j;-><init>(Lcom/taobao/monitor/impl/processor/b/a$b;Ljava/lang/String;Ljava/util/Map;)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/b/a$b;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public addBizStage(Ljava/lang/String;Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/processor/b/a$b$k;

    invoke-direct {v0, p0, p1, p2}, Lcom/taobao/monitor/impl/processor/b/a$b$k;-><init>(Lcom/taobao/monitor/impl/processor/b/a$b;Ljava/lang/String;Ljava/util/Map;)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/b/a$b;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public addProperty(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/processor/b/a$b$g;

    invoke-direct {v0, p0, p1, p2}, Lcom/taobao/monitor/impl/processor/b/a$b$g;-><init>(Lcom/taobao/monitor/impl/processor/b/a$b;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/b/a$b;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public addStatistic(Ljava/lang/String;D)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/processor/b/a$b$h;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/b/a$b$h;-><init>(Lcom/taobao/monitor/impl/processor/b/a$b;Ljava/lang/String;D)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/b/a$b;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onEnd()V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/processor/b/a$b$d;

    invoke-direct {v0, p0}, Lcom/taobao/monitor/impl/processor/b/a$b$d;-><init>(Lcom/taobao/monitor/impl/processor/b/a$b;)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/b/a$b;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onEvent(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/processor/b/a$b$e;

    invoke-direct {v0, p0, p1, p2}, Lcom/taobao/monitor/impl/processor/b/a$b$e;-><init>(Lcom/taobao/monitor/impl/processor/b/a$b;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/b/a$b;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onStage(Ljava/lang/String;J)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/processor/b/a$b$f;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/b/a$b$f;-><init>(Lcom/taobao/monitor/impl/processor/b/a$b;Ljava/lang/String;J)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/b/a$b;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onStart()V
    .locals 1

    .line 2
    new-instance v0, Lcom/taobao/monitor/impl/processor/b/a$b$a;

    invoke-direct {v0, p0}, Lcom/taobao/monitor/impl/processor/b/a$b$a;-><init>(Lcom/taobao/monitor/impl/processor/b/a$b;)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/b/a$b;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onStart(Ljava/lang/String;)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/processor/b/a$b$c;

    invoke-direct {v0, p0, p1}, Lcom/taobao/monitor/impl/processor/b/a$b$c;-><init>(Lcom/taobao/monitor/impl/processor/b/a$b;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/b/a$b;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onStop()V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/processor/b/a$b$b;

    invoke-direct {v0, p0}, Lcom/taobao/monitor/impl/processor/b/a$b$b;-><init>(Lcom/taobao/monitor/impl/processor/b/a$b;)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/b/a$b;->a(Ljava/lang/Runnable;)V

    return-void
.end method
