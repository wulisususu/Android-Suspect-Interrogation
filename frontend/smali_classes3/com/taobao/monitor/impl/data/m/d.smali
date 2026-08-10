.class Lcom/taobao/monitor/impl/data/m/d;
.super Ljava/lang/Object;
.source "WindowCallbackProxy.java"

# interfaces
.implements Ljava/lang/reflect/InvocationHandler;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/data/m/d$a;
    }
.end annotation


# instance fields
.field private final a:Landroid/view/Window$Callback;

.field final a:Lcom/taobao/monitor/impl/data/m/d$a;


# direct methods
.method constructor <init>(Landroid/view/Window$Callback;Lcom/taobao/monitor/impl/data/m/d$a;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/m/d;->a:Landroid/view/Window$Callback;

    iput-object p2, p0, Lcom/taobao/monitor/impl/data/m/d;->a:Lcom/taobao/monitor/impl/data/m/d$a;

    return-void
.end method


# virtual methods
.method public invoke(Ljava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 1
    invoke-virtual {p2}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object p1

    const-string v0, "dispatchTouchEvent"

    .line 2
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/m/d;->a:Lcom/taobao/monitor/impl/data/m/d$a;

    if-eqz p1, :cond_1

    if-eqz p3, :cond_1

    .line 4
    array-length v0, p3

    if-lt v0, v2, :cond_1

    .line 5
    aget-object v0, p3, v1

    .line 6
    instance-of v1, v0, Landroid/view/MotionEvent;

    if-eqz v1, :cond_1

    .line 7
    check-cast v0, Landroid/view/MotionEvent;

    invoke-interface {p1, v0}, Lcom/taobao/monitor/impl/data/m/d$a;->a(Landroid/view/MotionEvent;)V

    goto :goto_0

    :cond_0
    const-string v0, "dispatchKeyEvent"

    .line 11
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/taobao/monitor/impl/data/m/d;->a:Lcom/taobao/monitor/impl/data/m/d$a;

    if-eqz p1, :cond_1

    if-eqz p3, :cond_1

    .line 13
    array-length v0, p3

    if-lt v0, v2, :cond_1

    .line 14
    aget-object v0, p3, v1

    .line 15
    instance-of v1, v0, Landroid/view/KeyEvent;

    if-eqz v1, :cond_1

    .line 16
    check-cast v0, Landroid/view/KeyEvent;

    invoke-interface {p1, v0}, Lcom/taobao/monitor/impl/data/m/d$a;->a(Landroid/view/KeyEvent;)V

    :cond_1
    :goto_0
    iget-object p1, p0, Lcom/taobao/monitor/impl/data/m/d;->a:Landroid/view/Window$Callback;

    .line 22
    invoke-virtual {p2, p1, p3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method
