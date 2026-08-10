.class Lcom/taobao/monitor/impl/data/m/a;
.super Lcom/taobao/monitor/impl/data/a;
.source "ActivityDataCollector.java"

# interfaces
.implements Lcom/taobao/monitor/impl/data/m/b$b;
.implements Lcom/taobao/monitor/impl/data/m/d$a;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/taobao/monitor/impl/data/a<",
        "Landroid/app/Activity;",
        ">;",
        "Lcom/taobao/monitor/impl/data/m/b$b;",
        "Lcom/taobao/monitor/impl/data/m/d$a;"
    }
.end annotation


# instance fields
.field private final a:Landroid/app/Activity;

.field private a:Lcom/taobao/monitor/impl/data/d;

.field private a:Lcom/taobao/monitor/impl/trace/b;

.field private a:Lcom/taobao/monitor/impl/trace/c;

.field private f:Z

.field private g:Z


# direct methods
.method constructor <init>(Landroid/app/Activity;)V
    .locals 1

    .line 1
    invoke-direct {p0, p1}, Lcom/taobao/monitor/impl/data/a;-><init>(Ljava/lang/Object;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/b;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/m/a;->f:Z

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/m/a;->g:Z

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Landroid/app/Activity;

    .line 14
    new-instance p1, Lcom/taobao/monitor/impl/data/d;

    invoke-direct {p1}, Lcom/taobao/monitor/impl/data/d;-><init>()V

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/data/d;

    .line 16
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/data/m/a;->b()V

    return-void
.end method


# virtual methods
.method public a(Landroid/view/KeyEvent;)V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/b;

    .line 9
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/b;

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Landroid/app/Activity;

    .line 10
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0, v1, p1, v2, v3}, Lcom/taobao/monitor/impl/trace/b;->a(Landroid/app/Activity;Landroid/view/KeyEvent;J)V

    :cond_0
    return-void
.end method

.method public a(Landroid/view/MotionEvent;)V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/b;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/b;

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Landroid/app/Activity;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v0, v1, p1, v2, v3}, Lcom/taobao/monitor/impl/trace/b;->a(Landroid/app/Activity;Landroid/view/MotionEvent;J)V

    .line 4
    :cond_0
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    const/4 v2, 0x3

    invoke-virtual {p0, v2, v0, v1}, Lcom/taobao/monitor/impl/data/a;->b(IJ)V

    .line 5
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result p1

    const/4 v0, 0x2

    if-ne p1, v0, :cond_1

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/data/d;

    .line 8
    invoke-virtual {p1}, Lcom/taobao/monitor/impl/data/d;->a()V

    :cond_1
    return-void
.end method

.method protected b()V
    .locals 2

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/data/m/a;->g:Z

    if-eqz v0, :cond_0

    return-void

    .line 5
    :cond_0
    invoke-super {p0}, Lcom/taobao/monitor/impl/data/a;->b()V

    const-string v0, "ACTIVITY_LIFECYCLE_DISPATCHER"

    .line 6
    invoke-static {v0}, Lcom/taobao/monitor/impl/common/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    .line 7
    instance-of v1, v0, Lcom/taobao/monitor/impl/trace/c;

    if-eqz v1, :cond_1

    .line 8
    check-cast v0, Lcom/taobao/monitor/impl/trace/c;

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    :cond_1
    const-string v0, "ACTIVITY_EVENT_DISPATCHER"

    .line 11
    invoke-static {v0}, Lcom/taobao/monitor/impl/common/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    .line 12
    instance-of v1, v0, Lcom/taobao/monitor/impl/trace/b;

    if-eqz v1, :cond_2

    .line 13
    check-cast v0, Lcom/taobao/monitor/impl/trace/b;

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/b;

    :cond_2
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/m/a;->g:Z

    return-void
.end method

.method public onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 3

    .line 1
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/data/m/a;->b()V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 3
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, p2, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->a(Landroid/app/Activity;Landroid/os/Bundle;J)V

    :cond_0
    return-void
.end method

.method public onActivityDestroyed(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->a(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public onActivityPaused(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->b(Landroid/app/Activity;J)V

    .line 5
    :cond_0
    invoke-virtual {p1}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object p1

    .line 6
    invoke-virtual {p1}, Landroid/view/View;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object p1

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/data/d;

    .line 7
    invoke-virtual {p1, v0}, Landroid/view/ViewTreeObserver;->removeOnDrawListener(Landroid/view/ViewTreeObserver$OnDrawListener;)V

    return-void
.end method

.method public onActivityPostCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, p2, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->b(Landroid/app/Activity;Landroid/os/Bundle;J)V

    :cond_0
    return-void
.end method

.method public onActivityPostDestroyed(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->c(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public onActivityPostPaused(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->d(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public onActivityPostResumed(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->e(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public onActivityPostStarted(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->f(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public onActivityPostStopped(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->g(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public onActivityPreCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 3

    .line 1
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/data/m/a;->b()V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 3
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, p2, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->c(Landroid/app/Activity;Landroid/os/Bundle;J)V

    :cond_0
    return-void
.end method

.method public onActivityPreDestroyed(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->h(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public onActivityPrePaused(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->i(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public onActivityPreResumed(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->j(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public onActivityPreStarted(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->k(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public onActivityPreStopped(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->l(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public onActivityResumed(Landroid/app/Activity;)V
    .locals 7

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->m(Landroid/app/Activity;J)V

    .line 5
    :cond_0
    invoke-virtual {p1}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v0

    if-nez v0, :cond_1

    return-void

    .line 11
    :cond_1
    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v1

    if-nez v1, :cond_2

    return-void

    .line 16
    :cond_2
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->a(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/taobao/monitor/impl/processor/launcher/PageList;->inBlackList(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_3

    const-wide/16 v2, 0x0

    .line 17
    invoke-virtual {p0, v1, v2, v3}, Lcom/taobao/monitor/impl/data/a;->a(Landroid/view/View;J)V

    :cond_3
    iget-boolean p1, p0, Lcom/taobao/monitor/impl/data/m/a;->f:Z

    if-nez p1, :cond_5

    .line 21
    invoke-virtual {v0}, Landroid/view/Window;->getCallback()Landroid/view/Window$Callback;

    move-result-object p1

    const/4 v2, 0x1

    if-eqz p1, :cond_4

    .line 25
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v3

    new-array v4, v2, [Ljava/lang/Class;

    const-class v5, Landroid/view/Window$Callback;

    const/4 v6, 0x0

    aput-object v5, v4, v6

    new-instance v5, Lcom/taobao/monitor/impl/data/m/d;

    invoke-direct {v5, p1, p0}, Lcom/taobao/monitor/impl/data/m/d;-><init>(Landroid/view/Window$Callback;Lcom/taobao/monitor/impl/data/m/d$a;)V

    invoke-static {v3, v4, v5}, Ljava/lang/reflect/Proxy;->newProxyInstance(Ljava/lang/ClassLoader;[Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/Window$Callback;

    .line 26
    invoke-virtual {v0, p1}, Landroid/view/Window;->setCallback(Landroid/view/Window$Callback;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 28
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_4
    :goto_0
    iput-boolean v2, p0, Lcom/taobao/monitor/impl/data/m/a;->f:Z

    .line 36
    :cond_5
    invoke-virtual {v1}, Landroid/view/View;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object p1

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/data/d;

    .line 37
    invoke-virtual {p1, v0}, Landroid/view/ViewTreeObserver;->addOnDrawListener(Landroid/view/ViewTreeObserver$OnDrawListener;)V

    return-void
.end method

.method public onActivityStarted(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->n(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public onActivityStopped(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/g;->a(Lcom/taobao/monitor/impl/trace/IDispatcher;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 2
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->a(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/taobao/monitor/impl/processor/launcher/PageList;->inBlackList(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 4
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/data/a;->d()V

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/a;->a:Lcom/taobao/monitor/impl/trace/c;

    .line 6
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, p1, v1, v2}, Lcom/taobao/monitor/impl/trace/c;->o(Landroid/app/Activity;J)V

    .line 8
    :cond_1
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->a(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/taobao/monitor/impl/processor/launcher/PageList;->inBlackList(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    .line 9
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/data/a;->e()V

    :cond_2
    return-void
.end method
