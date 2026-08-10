.class public Lcom/taobao/monitor/impl/data/i;
.super Ljava/lang/Object;
.source "PageLoadCalculate.java"

# interfaces
.implements Lcom/taobao/monitor/impl/data/f;
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/data/i$b;
    }
.end annotation


# instance fields
.field private a:Lcom/taobao/application/common/IPageLoadCalculateListener;

.field private a:Lcom/taobao/monitor/impl/data/i$b;

.field private a:Ljava/lang/Object;

.field private final a:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private volatile a:Z


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/i;->a:Z

    .line 5
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/taobao/monitor/impl/data/i;->a:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method static synthetic a(Lcom/taobao/monitor/impl/data/i;Lcom/taobao/monitor/impl/data/i$b;)Lcom/taobao/monitor/impl/data/i$b;
    .locals 0

    .line 1
    iput-object p1, p0, Lcom/taobao/monitor/impl/data/i;->a:Lcom/taobao/monitor/impl/data/i$b;

    return-object p1
.end method

.method private a(Landroid/view/View;Landroid/view/View;)V
    .locals 6

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/i;->a:Lcom/taobao/monitor/impl/data/i$b;

    if-eqz v0, :cond_6

    .line 11
    new-instance v0, Lcom/taobao/monitor/impl/data/b;

    invoke-direct {v0, p1, p2}, Lcom/taobao/monitor/impl/data/b;-><init>(Landroid/view/View;Landroid/view/View;)V

    .line 12
    invoke-interface {v0}, Lcom/taobao/monitor/impl/data/e;->a()F

    move-result p1

    iget-object p2, p0, Lcom/taobao/monitor/impl/data/i;->a:Ljava/lang/Object;

    const-string v0, "PageLoadCalculate"

    const-string v1, "calculateDraw percent: "

    if-eqz p2, :cond_5

    .line 14
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p2

    const-class v2, Lcom/taobao/application/common/VisiblePercent;

    invoke-virtual {p2, v2}, Ljava/lang/Class;->getAnnotation(Ljava/lang/Class;)Ljava/lang/annotation/Annotation;

    move-result-object p2

    check-cast p2, Lcom/taobao/application/common/VisiblePercent;

    const/high16 v2, 0x3f800000    # 1.0f

    const-string v3, ", correct finished: "

    if-eqz p2, :cond_2

    .line 16
    invoke-interface {p2}, Lcom/taobao/application/common/VisiblePercent;->value()F

    move-result v4

    cmpl-float v4, p1, v4

    if-lez v4, :cond_0

    const/4 v4, 0x1

    goto :goto_0

    :cond_0
    const/4 v4, 0x0

    .line 17
    :goto_0
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v5, ", VisiblePercent value: "

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-interface {p2}, Lcom/taobao/application/common/VisiblePercent;->value()F

    move-result p2

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    filled-new-array {p2}, [Ljava/lang/Object;

    move-result-object p2

    invoke-static {v0, p2}, Lcom/taobao/monitor/impl/logger/Logger;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p2, p0, Lcom/taobao/monitor/impl/data/i;->a:Lcom/taobao/monitor/impl/data/i$b;

    if-eqz v4, :cond_1

    move p1, v2

    .line 18
    :cond_1
    invoke-interface {p2, p1}, Lcom/taobao/monitor/impl/data/i$b;->a(F)V

    goto :goto_1

    :cond_2
    iget-object p2, p0, Lcom/taobao/monitor/impl/data/i;->a:Lcom/taobao/application/common/IPageLoadCalculateListener;

    if-eqz p2, :cond_4

    iget-object v4, p0, Lcom/taobao/monitor/impl/data/i;->a:Ljava/lang/Object;

    .line 20
    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/taobao/monitor/impl/data/i;->a:Ljava/lang/Object;

    invoke-interface {p2, v4, v5, p1}, Lcom/taobao/application/common/IPageLoadCalculateListener;->onPageLoadCalculated(Ljava/lang/String;Ljava/lang/Object;F)Z

    move-result p2

    .line 21
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/taobao/monitor/impl/logger/Logger;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/i;->a:Lcom/taobao/monitor/impl/data/i$b;

    if-eqz p2, :cond_3

    move p1, v2

    .line 22
    :cond_3
    invoke-interface {v0, p1}, Lcom/taobao/monitor/impl/data/i$b;->a(F)V

    goto :goto_1

    .line 24
    :cond_4
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    filled-new-array {p2}, [Ljava/lang/Object;

    move-result-object p2

    invoke-static {v0, p2}, Lcom/taobao/monitor/impl/logger/Logger;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p2, p0, Lcom/taobao/monitor/impl/data/i;->a:Lcom/taobao/monitor/impl/data/i$b;

    .line 25
    invoke-interface {p2, p1}, Lcom/taobao/monitor/impl/data/i$b;->a(F)V

    goto :goto_1

    .line 28
    :cond_5
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    filled-new-array {p2}, [Ljava/lang/Object;

    move-result-object p2

    invoke-static {v0, p2}, Lcom/taobao/monitor/impl/logger/Logger;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p2, p0, Lcom/taobao/monitor/impl/data/i;->a:Lcom/taobao/monitor/impl/data/i$b;

    .line 29
    invoke-interface {p2, p1}, Lcom/taobao/monitor/impl/data/i$b;->a(F)V

    :cond_6
    :goto_1
    return-void
.end method

.method private c()V
    .locals 6

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/i;->a:Ljava/lang/ref/WeakReference;

    .line 1
    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    const-string v1, "PageLoadCalculate"

    if-nez v0, :cond_0

    .line 3
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/data/i;->a()V

    const-string v0, "check root view null, stop"

    .line 4
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/Logger;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 11
    :cond_0
    :try_start_0
    invoke-virtual {v0}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const-string v3, "content"

    const-string v4, "id"

    const-string v5, "android"

    .line 12
    invoke-virtual {v2, v3, v4, v5}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 14
    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    if-nez v2, :cond_1

    move-object v2, v0

    .line 19
    :cond_1
    invoke-virtual {v2}, Landroid/view/View;->getHeight()I

    move-result v3

    invoke-virtual {v2}, Landroid/view/View;->getWidth()I

    move-result v4

    mul-int/2addr v3, v4

    if-nez v3, :cond_2

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    const-string v2, "check not draw"

    const/4 v3, 0x0

    aput-object v2, v0, v3

    .line 20
    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/Logger;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 24
    :cond_2
    invoke-direct {p0, v2, v0}, Lcom/taobao/monitor/impl/data/i;->a(Landroid/view/View;Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 26
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "check exception: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/NullPointerException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/Logger;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/application/common/IPageLoadCalculateListener;)Lcom/taobao/monitor/impl/data/i;
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/i;->a:Lcom/taobao/application/common/IPageLoadCalculateListener;

    return-object p0
.end method

.method public a(Lcom/taobao/monitor/impl/data/i$b;)Lcom/taobao/monitor/impl/data/i;
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/i;->a:Lcom/taobao/monitor/impl/data/i$b;

    return-object p0
.end method

.method public a(Ljava/lang/Object;)Lcom/taobao/monitor/impl/data/i;
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/i;->a:Ljava/lang/Object;

    return-object p0
.end method

.method public a()V
    .locals 2

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/i;->a:Z

    .line 6
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->getAsyncUiHandler()Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 9
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    new-instance v1, Lcom/taobao/monitor/impl/data/i$a;

    invoke-direct {v1, p0}, Lcom/taobao/monitor/impl/data/i$a;-><init>(Lcom/taobao/monitor/impl/data/i;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public b()V
    .locals 3

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->getAsyncUiHandler()Landroid/os/Handler;

    move-result-object v0

    const-wide/16 v1, 0x32

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method public run()V
    .locals 3

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/data/i;->a:Z

    if-nez v0, :cond_0

    .line 2
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/i;->c()V

    .line 3
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->getAsyncUiHandler()Landroid/os/Handler;

    move-result-object v0

    const-wide/16 v1, 0x4b

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_0
    return-void
.end method
