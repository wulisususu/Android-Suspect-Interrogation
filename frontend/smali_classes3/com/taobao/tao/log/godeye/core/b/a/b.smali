.class public abstract Lcom/taobao/tao/log/godeye/core/b/a/b;
.super Ljava/lang/Object;
.source "Plugin.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/tao/log/godeye/core/b/a/b$a;
    }
.end annotation


# instance fields
.field protected a:Lcom/taobao/tao/log/godeye/core/b/a/b$a;


# direct methods
.method public constructor <init>(Lcom/taobao/tao/log/godeye/core/b/a/b$a;)V
    .locals 0

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/core/b/a/b;->a:Lcom/taobao/tao/log/godeye/core/b/a/b$a;

    return-void
.end method


# virtual methods
.method protected a(Ljava/lang/Class;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)V"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NoSuchMethodException;,
            Ljava/lang/IllegalAccessException;,
            Ljava/lang/InstantiationException;
        }
    .end annotation

    if-eqz p1, :cond_0

    .line 25
    const-class v0, Lcom/taobao/tao/log/godeye/api/c/a;

    invoke-virtual {v0, p1}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 26
    invoke-virtual {p1}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/tao/log/godeye/api/c/a;

    .line 27
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->getApplication()Landroid/app/Application;

    move-result-object v0

    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v1

    invoke-interface {p1, v0, v1}, Lcom/taobao/tao/log/godeye/api/c/a;->a(Landroid/app/Application;Lcom/taobao/tao/log/godeye/api/b/b;)V

    :cond_0
    return-void
.end method

.method public abstract execute()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation
.end method
