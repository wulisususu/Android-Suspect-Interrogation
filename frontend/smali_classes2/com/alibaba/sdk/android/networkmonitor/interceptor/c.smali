.class public abstract Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;
.super Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;
.source "OkHttpInterceptorHelper.java"

# interfaces
.implements Lcom/alibaba/sdk/android/networkmonitor/utils/a;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<C:",
        "Ljava/lang/Object;",
        ">",
        "Lcom/alibaba/sdk/android/networkmonitor/interceptor/a<",
        "TC;>;",
        "Lcom/alibaba/sdk/android/networkmonitor/utils/a;"
    }
.end annotation


# instance fields
.field private a:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "TC;",
            "Lcom/alibaba/sdk/android/networkmonitor/a;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 5
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 6
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;->getInstance()Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;

    move-result-object v0

    check-cast v0, Lcom/alibaba/sdk/android/networkmonitor/b;

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/networkmonitor/b;->a(Lcom/alibaba/sdk/android/networkmonitor/utils/a;)V

    return-void
.end method

.method private a(Lcom/alibaba/sdk/android/networkmonitor/c;)V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 19
    invoke-virtual {v0}, Ljava/util/concurrent/ConcurrentHashMap;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 20
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 21
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/sdk/android/networkmonitor/a;

    .line 23
    invoke-virtual {v1, p1}, Lcom/alibaba/sdk/android/networkmonitor/a;->a(Lcom/alibaba/sdk/android/networkmonitor/e;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;Lcom/alibaba/sdk/android/networkmonitor/c;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;->a(Lcom/alibaba/sdk/android/networkmonitor/c;)V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/Object;)Lcom/alibaba/sdk/android/networkmonitor/a;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;)",
            "Lcom/alibaba/sdk/android/networkmonitor/a;"
        }
    .end annotation

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;->a:Ljava/util/concurrent/ConcurrentHashMap;

    if-eqz v0, :cond_1

    .line 12
    invoke-virtual {v0}, Ljava/util/concurrent/ConcurrentHashMap;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 16
    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/alibaba/sdk/android/networkmonitor/a;

    return-object p1

    :cond_1
    :goto_0
    const/4 p1, 0x0

    return-object p1
.end method

.method protected a()V
    .locals 6

    .line 2
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    const-wide/32 v2, 0x493e0

    sub-long/2addr v0, v2

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 3
    invoke-virtual {v2}, Ljava/util/concurrent/ConcurrentHashMap;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 4
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    .line 5
    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/alibaba/sdk/android/networkmonitor/a;

    if-nez v3, :cond_1

    .line 8
    invoke-interface {v2}, Ljava/util/Iterator;->remove()V

    goto :goto_0

    .line 9
    :cond_1
    invoke-virtual {v3}, Lcom/alibaba/sdk/android/networkmonitor/a;->a()J

    move-result-wide v4

    cmp-long v4, v4, v0

    if-gez v4, :cond_0

    .line 10
    invoke-interface {v2}, Ljava/util/Iterator;->remove()V

    .line 11
    invoke-virtual {p0, v3}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Lcom/alibaba/sdk/android/networkmonitor/a;)V

    goto :goto_0

    :cond_2
    return-void
.end method

.method public a(J)V
    .locals 2

    .line 18
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v0

    new-instance v1, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c$a;

    invoke-direct {v1, p0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c$a;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;J)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method protected a(Ljava/lang/Object;Lcom/alibaba/sdk/android/networkmonitor/a;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;",
            "Lcom/alibaba/sdk/android/networkmonitor/a;",
            ")V"
        }
    .end annotation

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 17
    invoke-virtual {v0, p1, p2}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method protected b(Ljava/lang/Object;)Lcom/alibaba/sdk/android/networkmonitor/a;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TC;)",
            "Lcom/alibaba/sdk/android/networkmonitor/a;"
        }
    .end annotation

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 1
    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/alibaba/sdk/android/networkmonitor/a;

    return-object p1
.end method

.method public b(J)V
    .locals 2

    .line 2
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Lcom/alibaba/sdk/android/networkmonitor/utils/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/utils/b;->a()Landroid/os/Handler;

    move-result-object v0

    new-instance v1, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c$b;

    invoke-direct {v1, p0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c$b;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;J)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
