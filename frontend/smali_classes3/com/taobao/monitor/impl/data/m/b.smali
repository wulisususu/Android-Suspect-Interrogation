.class public Lcom/taobao/monitor/impl/data/m/b;
.super Ljava/lang/Object;
.source "ActivityLifecycle.java"

# interfaces
.implements Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/data/m/b$b;
    }
.end annotation


# static fields
.field public static a:Z = false


# instance fields
.field private a:I

.field private final a:Landroid/app/Application$ActivityLifecycleCallbacks;

.field private final a:Lcom/taobao/application/common/data/b;

.field private final a:Lcom/taobao/monitor/impl/data/m/c;

.field protected a:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Landroid/app/Activity;",
            "Lcom/taobao/monitor/impl/data/m/b$b;",
            ">;"
        }
    .end annotation
.end field

.field private final b:Landroid/app/Application$ActivityLifecycleCallbacks;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 5
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/application/common/impl/b;->b()Landroid/app/Application$ActivityLifecycleCallbacks;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 8
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/application/common/impl/b;->a()Landroid/app/Application$ActivityLifecycleCallbacks;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->b:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 10
    new-instance v0, Lcom/taobao/monitor/impl/data/m/c;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/data/m/c;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Lcom/taobao/monitor/impl/data/m/c;

    const/4 v0, 0x0

    iput v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:I

    .line 15
    new-instance v0, Lcom/taobao/application/common/data/b;

    invoke-direct {v0}, Lcom/taobao/application/common/data/b;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Lcom/taobao/application/common/data/b;

    iget v1, p0, Lcom/taobao/monitor/impl/data/m/b;->a:I

    .line 20
    invoke-virtual {v0, v1}, Lcom/taobao/application/common/data/b;->a(I)V

    return-void
.end method

.method private a(Ljava/lang/String;)V
    .locals 2

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    new-instance v1, Lcom/taobao/monitor/impl/data/m/b$a;

    invoke-direct {v1, p0, p1}, Lcom/taobao/monitor/impl/data/m/b$a;-><init>(Lcom/taobao/monitor/impl/data/m/b;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method


# virtual methods
.method public onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Lcom/taobao/application/common/data/b;

    iget v1, p0, Lcom/taobao/monitor/impl/data/m/b;->a:I

    const/4 v2, 0x1

    add-int/2addr v1, v2

    iput v1, p0, Lcom/taobao/monitor/impl/data/m/b;->a:I

    .line 1
    invoke-virtual {v0, v1}, Lcom/taobao/application/common/data/b;->a(I)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    if-nez v0, :cond_0

    .line 4
    sget v0, Lcom/taobao/monitor/impl/data/GlobalStats;->createdPageCount:I

    add-int/2addr v0, v2

    sput v0, Lcom/taobao/monitor/impl/data/GlobalStats;->createdPageCount:I

    .line 5
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->a(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object v0

    .line 6
    sget-object v1, Lcom/taobao/monitor/impl/data/GlobalStats;->activityStatusManager:Lcom/taobao/monitor/impl/data/GlobalStats$a;

    invoke-virtual {v1, v0}, Lcom/taobao/monitor/impl/data/GlobalStats$a;->a(Ljava/lang/String;)V

    .line 7
    new-instance v0, Lcom/taobao/monitor/impl/data/m/a;

    invoke-direct {v0, p1}, Lcom/taobao/monitor/impl/data/m/a;-><init>(Landroid/app/Activity;)V

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 8
    invoke-interface {v1, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 9
    invoke-interface {v0, p1, p2}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V

    .line 11
    instance-of v0, p1, Landroidx/fragment/app/FragmentActivity;

    if-eqz v0, :cond_1

    sget-boolean v0, Lcom/taobao/monitor/impl/common/DynamicConstants;->needFragment:Z

    if-eqz v0, :cond_1

    .line 12
    move-object v0, p1

    check-cast v0, Landroidx/fragment/app/FragmentActivity;

    .line 13
    invoke-virtual {v0}, Landroidx/fragment/app/FragmentActivity;->getSupportFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v0

    .line 14
    new-instance v1, Lcom/taobao/monitor/impl/data/n/b;

    invoke-direct {v1, p1}, Lcom/taobao/monitor/impl/data/n/b;-><init>(Landroid/app/Activity;)V

    invoke-virtual {v0, v1, v2}, Landroidx/fragment/app/FragmentManager;->registerFragmentLifecycleCallbacks(Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;Z)V

    goto :goto_0

    .line 17
    :cond_0
    invoke-interface {v0, p1, p2}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V

    .line 19
    :cond_1
    :goto_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onActivityCreated"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 20
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/taobao/application/common/impl/b;->a(Landroid/app/Activity;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 21
    invoke-interface {v0, p1, p2}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->b:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 22
    invoke-interface {v0, p1, p2}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V

    return-void
.end method

.method public onActivityDestroyed(Landroid/app/Activity;)V
    .locals 2

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onActivityDestroyed"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityDestroyed(Landroid/app/Activity;)V

    :cond_0
    sget-boolean v0, Lcom/taobao/monitor/impl/data/m/b;->a:Z

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 8
    invoke-interface {v0, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 9
    sget-boolean v0, Lcom/taobao/monitor/impl/data/GlobalStats;->isBackground:Z

    if-eqz v0, :cond_1

    const-string v0, ""

    .line 10
    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/data/m/b;->a(Ljava/lang/String;)V

    .line 11
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/taobao/application/common/impl/b;->a(Landroid/app/Activity;)V

    :cond_1
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 14
    invoke-interface {v0, p1}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivityDestroyed(Landroid/app/Activity;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->b:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 15
    invoke-interface {v0, p1}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivityDestroyed(Landroid/app/Activity;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Lcom/taobao/application/common/data/b;

    iget v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:I

    .line 16
    invoke-virtual {p1, v0}, Lcom/taobao/application/common/data/b;->a(I)V

    :cond_2
    return-void
.end method

.method public onActivityPaused(Landroid/app/Activity;)V
    .locals 2

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onActivityPaused"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityPaused(Landroid/app/Activity;)V

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 6
    invoke-interface {v0, p1}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivityPaused(Landroid/app/Activity;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->b:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 7
    invoke-interface {v0, p1}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivityPaused(Landroid/app/Activity;)V

    return-void
.end method

.method public onActivityPostCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 2

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onActivityPostCreated"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1, p2}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityPostCreated(Landroid/app/Activity;Landroid/os/Bundle;)V

    :cond_0
    return-void
.end method

.method public onActivityPostDestroyed(Landroid/app/Activity;)V
    .locals 2

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onActivityPostDestroyed"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityPostDestroyed(Landroid/app/Activity;)V

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 7
    invoke-interface {v0, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 8
    sget-boolean v0, Lcom/taobao/monitor/impl/data/GlobalStats;->isBackground:Z

    if-eqz v0, :cond_1

    const-string v0, ""

    .line 9
    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/data/m/b;->a(Ljava/lang/String;)V

    .line 10
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/taobao/application/common/impl/b;->a(Landroid/app/Activity;)V

    :cond_1
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 13
    invoke-interface {v0, p1}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivityDestroyed(Landroid/app/Activity;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->b:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 14
    invoke-interface {v0, p1}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivityDestroyed(Landroid/app/Activity;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Lcom/taobao/application/common/data/b;

    iget v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:I

    .line 15
    invoke-virtual {p1, v0}, Lcom/taobao/application/common/data/b;->a(I)V

    return-void
.end method

.method public onActivityPostPaused(Landroid/app/Activity;)V
    .locals 2

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onActivityPostPaused"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityPostPaused(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPostResumed(Landroid/app/Activity;)V
    .locals 2

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onActivityPostResumed"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityPostResumed(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPostSaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 0

    return-void
.end method

.method public onActivityPostStarted(Landroid/app/Activity;)V
    .locals 2

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onActivityPostStarted"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityPostStarted(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPostStopped(Landroid/app/Activity;)V
    .locals 2

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onActivityPostStopped"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityPostStopped(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPreCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 3

    const/4 v0, 0x1

    sput-boolean v0, Lcom/taobao/monitor/impl/data/m/b;->a:Z

    .line 2
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "onActivityPreCreated"

    filled-new-array {v2, v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "ActivityLifeCycle"

    invoke-static {v2, v1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 3
    invoke-interface {v1, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/monitor/impl/data/m/b$b;

    if-eqz v1, :cond_0

    .line 5
    invoke-interface {v1, p1, p2}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityPreCreated(Landroid/app/Activity;Landroid/os/Bundle;)V

    goto :goto_0

    .line 7
    :cond_0
    sget v1, Lcom/taobao/monitor/impl/data/GlobalStats;->createdPageCount:I

    add-int/2addr v1, v0

    sput v1, Lcom/taobao/monitor/impl/data/GlobalStats;->createdPageCount:I

    .line 8
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->a(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object v1

    .line 9
    sget-object v2, Lcom/taobao/monitor/impl/data/GlobalStats;->activityStatusManager:Lcom/taobao/monitor/impl/data/GlobalStats$a;

    invoke-virtual {v2, v1}, Lcom/taobao/monitor/impl/data/GlobalStats$a;->a(Ljava/lang/String;)V

    .line 10
    new-instance v1, Lcom/taobao/monitor/impl/data/m/a;

    invoke-direct {v1, p1}, Lcom/taobao/monitor/impl/data/m/a;-><init>(Landroid/app/Activity;)V

    iget-object v2, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 11
    invoke-interface {v2, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 12
    invoke-interface {v1, p1, p2}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityPreCreated(Landroid/app/Activity;Landroid/os/Bundle;)V

    .line 14
    instance-of p2, p1, Landroidx/fragment/app/FragmentActivity;

    if-eqz p2, :cond_1

    sget-boolean p2, Lcom/taobao/monitor/impl/common/DynamicConstants;->needFragment:Z

    if-eqz p2, :cond_1

    .line 15
    move-object p2, p1

    check-cast p2, Landroidx/fragment/app/FragmentActivity;

    .line 16
    invoke-virtual {p2}, Landroidx/fragment/app/FragmentActivity;->getSupportFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object p2

    .line 17
    new-instance v1, Lcom/taobao/monitor/impl/data/n/b;

    invoke-direct {v1, p1}, Lcom/taobao/monitor/impl/data/n/b;-><init>(Landroid/app/Activity;)V

    invoke-virtual {p2, v1, v0}, Landroidx/fragment/app/FragmentManager;->registerFragmentLifecycleCallbacks(Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;Z)V

    :cond_1
    :goto_0
    return-void
.end method

.method public onActivityPreDestroyed(Landroid/app/Activity;)V
    .locals 2

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onActivityPreDestroyed"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityPreDestroyed(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPrePaused(Landroid/app/Activity;)V
    .locals 2

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onActivityPrePaused"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityPrePaused(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPreResumed(Landroid/app/Activity;)V
    .locals 2

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onActivityPreResumed"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityPreResumed(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPreSaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 0

    return-void
.end method

.method public onActivityPreStarted(Landroid/app/Activity;)V
    .locals 2

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onActivityPreStarted"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityPreStarted(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPreStopped(Landroid/app/Activity;)V
    .locals 2

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onActivityPreStopped"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityPreStopped(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityResumed(Landroid/app/Activity;)V
    .locals 2

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onActivityResumed"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityResumed(Landroid/app/Activity;)V

    .line 6
    :cond_0
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/taobao/application/common/impl/b;->a(Landroid/app/Activity;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 7
    invoke-interface {v0, p1}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivityResumed(Landroid/app/Activity;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->b:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 8
    invoke-interface {v0, p1}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivityResumed(Landroid/app/Activity;)V

    return-void
.end method

.method public onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 1
    invoke-interface {v0, p1, p2}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->b:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 2
    invoke-interface {v0, p1, p2}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V

    return-void
.end method

.method public onActivityStarted(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    .line 2
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "onActivityStarted"

    filled-new-array {v2, v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "ActivityLifeCycle"

    invoke-static {v2, v1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    if-eqz v0, :cond_0

    .line 5
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityStarted(Landroid/app/Activity;)V

    .line 7
    :cond_0
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/taobao/application/common/impl/b;->a(Landroid/app/Activity;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 8
    invoke-interface {v0, p1}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivityStarted(Landroid/app/Activity;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->b:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 9
    invoke-interface {v0, p1}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivityStarted(Landroid/app/Activity;)V

    return-void
.end method

.method public onActivityStopped(Landroid/app/Activity;)V
    .locals 2

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "onActivityStopped"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/data/m/b$b;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/m/b$b;->onActivityStopped(Landroid/app/Activity;)V

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 7
    invoke-interface {v0, p1}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivityStopped(Landroid/app/Activity;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->b:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 8
    invoke-interface {v0, p1}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivityStopped(Landroid/app/Activity;)V

    return-void
.end method

.method public onBackground(Landroid/app/Activity;)V
    .locals 4

    const/4 v0, 0x1

    .line 1
    sput-boolean v0, Lcom/taobao/monitor/impl/data/GlobalStats;->isBackground:Z

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->instance()Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->setCurrentActivityProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V

    .line 3
    invoke-static {}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->instance()Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;

    move-result-object v1

    invoke-virtual {v1, v2}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->setCurrentFragmentProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V

    const-string v1, "APPLICATION_BACKGROUND_CHANGED_DISPATCHER"

    .line 5
    invoke-static {v1}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v1

    .line 6
    instance-of v2, v1, Lcom/taobao/monitor/impl/trace/d;

    if-eqz v2, :cond_0

    .line 7
    check-cast v1, Lcom/taobao/monitor/impl/trace/d;

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, v0, v2, v3}, Lcom/taobao/monitor/impl/trace/d;->a(IJ)V

    :cond_0
    const-string v0, "foreground2Background"

    .line 10
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ActivityLifeCycle"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    const-string v0, "background"

    .line 11
    sput-object v0, Lcom/taobao/monitor/impl/data/GlobalStats;->lastValidPage:Ljava/lang/String;

    const-wide/16 v0, -0x1

    .line 12
    sput-wide v0, Lcom/taobao/monitor/impl/data/GlobalStats;->lastValidTime:J

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Lcom/taobao/monitor/impl/data/m/c;

    .line 13
    invoke-virtual {v0}, Lcom/taobao/monitor/impl/data/m/c;->b()V

    .line 14
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->a(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/taobao/monitor/impl/data/m/b;->a(Ljava/lang/String;)V

    return-void
.end method

.method public onForeground(Landroid/app/Activity;)V
    .locals 4

    const-string p1, "APPLICATION_BACKGROUND_CHANGED_DISPATCHER"

    .line 1
    invoke-static {p1}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object p1

    .line 2
    instance-of v0, p1, Lcom/taobao/monitor/impl/trace/d;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 3
    check-cast p1, Lcom/taobao/monitor/impl/trace/d;

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {p1, v1, v2, v3}, Lcom/taobao/monitor/impl/trace/d;->a(IJ)V

    :cond_0
    const-string p1, "background2Foreground"

    .line 6
    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v0, "ActivityLifeCycle"

    invoke-static {v0, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/m/b;->a:Lcom/taobao/monitor/impl/data/m/c;

    .line 7
    invoke-virtual {p1}, Lcom/taobao/monitor/impl/data/m/c;->a()V

    .line 9
    sput-boolean v1, Lcom/taobao/monitor/impl/data/GlobalStats;->isBackground:Z

    return-void
.end method
