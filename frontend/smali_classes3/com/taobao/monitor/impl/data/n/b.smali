.class public Lcom/taobao/monitor/impl/data/n/b;
.super Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;
.source "FragmentLifecycle.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/data/n/b$a;
    }
.end annotation


# static fields
.field private static a:Lcom/taobao/monitor/impl/trace/j;


# instance fields
.field private final a:Landroid/app/Activity;

.field protected a:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Landroidx/fragment/app/Fragment;",
            "Lcom/taobao/monitor/impl/data/n/b$a;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    sget-object v0, Lcom/taobao/monitor/impl/trace/j;->a:Lcom/taobao/monitor/impl/trace/j;

    sput-object v0, Lcom/taobao/monitor/impl/data/n/b;->a:Lcom/taobao/monitor/impl/trace/j;

    return-void
.end method

.method public constructor <init>(Landroid/app/Activity;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;-><init>()V

    .line 2
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Landroid/app/Activity;

    return-void
.end method


# virtual methods
.method public onFragmentActivityCreated(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Landroid/os/Bundle;)V
    .locals 6

    .line 1
    invoke-super {p0, p1, p2, p3}, Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;->onFragmentActivityCreated(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Landroid/os/Bundle;)V

    sget-object v0, Lcom/taobao/monitor/impl/data/n/b;->a:Lcom/taobao/monitor/impl/trace/j;

    .line 2
    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v4

    const-string v3, "onFragmentActivityCreated"

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/j;->a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V

    .line 3
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string p3, "onFragmentActivityCreated"

    filled-new-array {p3, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p3, "FragmentLifecycle"

    invoke-static {p3, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    .line 5
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/monitor/impl/data/n/b$a;

    if-eqz p1, :cond_0

    .line 7
    invoke-interface {p1, p2}, Lcom/taobao/monitor/impl/data/n/b$a;->m(Landroidx/fragment/app/Fragment;)V

    :cond_0
    return-void
.end method

.method public onFragmentAttached(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Landroid/content/Context;)V
    .locals 6

    .line 1
    invoke-super {p0, p1, p2, p3}, Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;->onFragmentAttached(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Landroid/content/Context;)V

    sget-object v0, Lcom/taobao/monitor/impl/data/n/b;->a:Lcom/taobao/monitor/impl/trace/j;

    .line 2
    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v4

    const-string v3, "onFragmentAttached"

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/j;->a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V

    .line 3
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string p3, "onFragmentAttached"

    filled-new-array {p3, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p3, "FragmentLifecycle"

    invoke-static {p3, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    .line 5
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/monitor/impl/data/n/b$a;

    if-eqz p1, :cond_0

    .line 7
    invoke-interface {p1, p2}, Lcom/taobao/monitor/impl/data/n/b$a;->h(Landroidx/fragment/app/Fragment;)V

    :cond_0
    return-void
.end method

.method public onFragmentCreated(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Landroid/os/Bundle;)V
    .locals 6

    .line 1
    invoke-super {p0, p1, p2, p3}, Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;->onFragmentCreated(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Landroid/os/Bundle;)V

    sget-object v0, Lcom/taobao/monitor/impl/data/n/b;->a:Lcom/taobao/monitor/impl/trace/j;

    .line 2
    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v4

    const-string v3, "onFragmentCreated"

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/j;->a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V

    .line 3
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string p3, "onFragmentCreated"

    filled-new-array {p3, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p3, "FragmentLifecycle"

    invoke-static {p3, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    .line 5
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/monitor/impl/data/n/b$a;

    if-eqz p1, :cond_0

    .line 7
    invoke-interface {p1, p2}, Lcom/taobao/monitor/impl/data/n/b$a;->i(Landroidx/fragment/app/Fragment;)V

    :cond_0
    return-void
.end method

.method public onFragmentDestroyed(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)V
    .locals 6

    .line 1
    invoke-super {p0, p1, p2}, Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;->onFragmentDestroyed(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)V

    sget-object v0, Lcom/taobao/monitor/impl/data/n/b;->a:Lcom/taobao/monitor/impl/trace/j;

    .line 2
    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v4

    const-string v3, "onFragmentDestroyed"

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/j;->a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V

    .line 3
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string v0, "onFragmentDestroyed"

    filled-new-array {v0, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v0, "FragmentLifecycle"

    invoke-static {v0, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    .line 4
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/monitor/impl/data/n/b$a;

    if-eqz p1, :cond_0

    .line 6
    invoke-interface {p1, p2}, Lcom/taobao/monitor/impl/data/n/b$a;->k(Landroidx/fragment/app/Fragment;)V

    :cond_0
    return-void
.end method

.method public onFragmentDetached(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)V
    .locals 6

    .line 1
    invoke-super {p0, p1, p2}, Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;->onFragmentDetached(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)V

    sget-object v0, Lcom/taobao/monitor/impl/data/n/b;->a:Lcom/taobao/monitor/impl/trace/j;

    .line 2
    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v4

    const-string v3, "onFragmentDetached"

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/j;->a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V

    .line 3
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string v0, "onFragmentDetached"

    filled-new-array {v0, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v0, "FragmentLifecycle"

    invoke-static {v0, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    .line 5
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/monitor/impl/data/n/b$a;

    if-eqz p1, :cond_0

    .line 7
    invoke-interface {p1, p2}, Lcom/taobao/monitor/impl/data/n/b$a;->j(Landroidx/fragment/app/Fragment;)V

    :cond_0
    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    .line 9
    invoke-interface {p1, p2}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public onFragmentPaused(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)V
    .locals 6

    .line 1
    invoke-super {p0, p1, p2}, Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;->onFragmentPaused(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)V

    sget-object v0, Lcom/taobao/monitor/impl/data/n/b;->a:Lcom/taobao/monitor/impl/trace/j;

    .line 2
    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v4

    const-string v3, "onFragmentPaused"

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/j;->a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V

    .line 3
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string v0, "onFragmentPaused"

    filled-new-array {v0, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v0, "FragmentLifecycle"

    invoke-static {v0, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    .line 5
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/monitor/impl/data/n/b$a;

    if-eqz p1, :cond_0

    .line 7
    invoke-interface {p1, p2}, Lcom/taobao/monitor/impl/data/n/b$a;->f(Landroidx/fragment/app/Fragment;)V

    :cond_0
    return-void
.end method

.method public onFragmentPreAttached(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Landroid/content/Context;)V
    .locals 6

    .line 1
    invoke-super {p0, p1, p2, p3}, Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;->onFragmentPreAttached(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Landroid/content/Context;)V

    .line 2
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string p3, "onFragmentPreAttached"

    filled-new-array {p3, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p3, "FragmentLifecycle"

    invoke-static {p3, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    sget-object v0, Lcom/taobao/monitor/impl/data/n/b;->a:Lcom/taobao/monitor/impl/trace/j;

    .line 3
    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v4

    const-string v3, "onFragmentPreAttached"

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/j;->a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    .line 5
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/monitor/impl/data/n/b$a;

    if-nez p1, :cond_0

    .line 7
    new-instance p1, Lcom/taobao/monitor/impl/data/n/a;

    iget-object p3, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Landroid/app/Activity;

    invoke-direct {p1, p3, p2}, Lcom/taobao/monitor/impl/data/n/a;-><init>(Landroid/app/Activity;Landroidx/fragment/app/Fragment;)V

    iget-object p3, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    .line 8
    invoke-interface {p3, p2, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 10
    :cond_0
    invoke-interface {p1, p2}, Lcom/taobao/monitor/impl/data/n/b$a;->g(Landroidx/fragment/app/Fragment;)V

    return-void
.end method

.method public onFragmentPreCreated(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Landroid/os/Bundle;)V
    .locals 6

    .line 1
    invoke-super {p0, p1, p2, p3}, Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;->onFragmentPreCreated(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Landroid/os/Bundle;)V

    sget-object v0, Lcom/taobao/monitor/impl/data/n/b;->a:Lcom/taobao/monitor/impl/trace/j;

    .line 2
    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v4

    const-string v3, "onFragmentPreCreated"

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/j;->a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V

    .line 3
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string p3, "onFragmentPreCreated"

    filled-new-array {p3, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p3, "FragmentLifecycle"

    invoke-static {p3, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    .line 5
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/monitor/impl/data/n/b$a;

    if-eqz p1, :cond_0

    .line 7
    invoke-interface {p1, p2}, Lcom/taobao/monitor/impl/data/n/b$a;->d(Landroidx/fragment/app/Fragment;)V

    :cond_0
    return-void
.end method

.method public onFragmentResumed(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)V
    .locals 6

    .line 1
    invoke-super {p0, p1, p2}, Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;->onFragmentResumed(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)V

    sget-object v0, Lcom/taobao/monitor/impl/data/n/b;->a:Lcom/taobao/monitor/impl/trace/j;

    .line 2
    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v4

    const-string v3, "onFragmentResumed"

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/j;->a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V

    .line 3
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string v0, "onFragmentResumed"

    filled-new-array {v0, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v0, "FragmentLifecycle"

    invoke-static {v0, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    .line 5
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/monitor/impl/data/n/b$a;

    if-eqz p1, :cond_0

    .line 7
    invoke-interface {p1, p2}, Lcom/taobao/monitor/impl/data/n/b$a;->l(Landroidx/fragment/app/Fragment;)V

    :cond_0
    return-void
.end method

.method public onFragmentSaveInstanceState(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Landroid/os/Bundle;)V
    .locals 6

    .line 1
    invoke-super {p0, p1, p2, p3}, Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;->onFragmentSaveInstanceState(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Landroid/os/Bundle;)V

    sget-object v0, Lcom/taobao/monitor/impl/data/n/b;->a:Lcom/taobao/monitor/impl/trace/j;

    .line 2
    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v4

    const-string v3, "onFragmentSaveInstanceState"

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/j;->a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V

    .line 3
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string p3, "onFragmentSaveInstanceState"

    filled-new-array {p3, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p3, "FragmentLifecycle"

    invoke-static {p3, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    .line 5
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/monitor/impl/data/n/b$a;

    if-eqz p1, :cond_0

    .line 7
    invoke-interface {p1, p2}, Lcom/taobao/monitor/impl/data/n/b$a;->e(Landroidx/fragment/app/Fragment;)V

    :cond_0
    return-void
.end method

.method public onFragmentStarted(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)V
    .locals 6

    .line 1
    invoke-super {p0, p1, p2}, Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;->onFragmentStarted(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)V

    sget-object v0, Lcom/taobao/monitor/impl/data/n/b;->a:Lcom/taobao/monitor/impl/trace/j;

    .line 2
    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v4

    const-string v3, "onFragmentStarted"

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/j;->a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V

    .line 3
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string v0, "onFragmentStarted"

    filled-new-array {v0, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v0, "FragmentLifecycle"

    invoke-static {v0, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    .line 5
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/monitor/impl/data/n/b$a;

    if-eqz p1, :cond_0

    .line 7
    invoke-interface {p1, p2}, Lcom/taobao/monitor/impl/data/n/b$a;->b(Landroidx/fragment/app/Fragment;)V

    :cond_0
    return-void
.end method

.method public onFragmentStopped(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)V
    .locals 6

    .line 1
    invoke-super {p0, p1, p2}, Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;->onFragmentStopped(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)V

    sget-object v0, Lcom/taobao/monitor/impl/data/n/b;->a:Lcom/taobao/monitor/impl/trace/j;

    .line 2
    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v4

    const-string v3, "onFragmentStopped"

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/j;->a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V

    .line 3
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string v0, "onFragmentStopped"

    filled-new-array {v0, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v0, "FragmentLifecycle"

    invoke-static {v0, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    .line 5
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/monitor/impl/data/n/b$a;

    if-eqz p1, :cond_0

    .line 7
    invoke-interface {p1, p2}, Lcom/taobao/monitor/impl/data/n/b$a;->a(Landroidx/fragment/app/Fragment;)V

    :cond_0
    return-void
.end method

.method public onFragmentViewCreated(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Landroid/view/View;Landroid/os/Bundle;)V
    .locals 6

    .line 1
    invoke-super {p0, p1, p2, p3, p4}, Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;->onFragmentViewCreated(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Landroid/view/View;Landroid/os/Bundle;)V

    sget-object v0, Lcom/taobao/monitor/impl/data/n/b;->a:Lcom/taobao/monitor/impl/trace/j;

    .line 2
    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v4

    const-string v3, "onFragmentViewCreated"

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/j;->a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V

    .line 3
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string p3, "onFragmentViewCreated"

    filled-new-array {p3, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p3, "FragmentLifecycle"

    invoke-static {p3, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    .line 5
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/monitor/impl/data/n/b$a;

    if-eqz p1, :cond_0

    .line 7
    invoke-interface {p1, p2}, Lcom/taobao/monitor/impl/data/n/b$a;->n(Landroidx/fragment/app/Fragment;)V

    :cond_0
    return-void
.end method

.method public onFragmentViewDestroyed(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)V
    .locals 6

    .line 1
    invoke-super {p0, p1, p2}, Landroidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks;->onFragmentViewDestroyed(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)V

    sget-object v0, Lcom/taobao/monitor/impl/data/n/b;->a:Lcom/taobao/monitor/impl/trace/j;

    .line 2
    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v4

    const-string v3, "onFragmentViewDestroyed"

    move-object v2, p2

    invoke-virtual/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/j;->a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V

    .line 3
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    const-string v0, "onFragmentViewDestroyed"

    filled-new-array {v0, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v0, "FragmentLifecycle"

    invoke-static {v0, p1}, Lcom/taobao/monitor/impl/logger/DataLoggerUtils;->log(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/n/b;->a:Ljava/util/Map;

    .line 5
    invoke-interface {p1, p2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/monitor/impl/data/n/b$a;

    if-eqz p1, :cond_0

    .line 7
    invoke-interface {p1, p2}, Lcom/taobao/monitor/impl/data/n/b$a;->c(Landroidx/fragment/app/Fragment;)V

    :cond_0
    return-void
.end method
