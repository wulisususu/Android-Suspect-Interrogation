.class Lcom/taobao/application/common/impl/c$b;
.super Ljava/lang/Object;
.source "AppLaunchListenerGroup.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/application/common/impl/c;->b(Lcom/taobao/application/common/IAppLaunchListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/application/common/IAppLaunchListener;

.field final synthetic a:Lcom/taobao/application/common/impl/c;


# direct methods
.method constructor <init>(Lcom/taobao/application/common/impl/c;Lcom/taobao/application/common/IAppLaunchListener;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/application/common/impl/c$b;->a:Lcom/taobao/application/common/impl/c;

    iput-object p2, p0, Lcom/taobao/application/common/impl/c$b;->a:Lcom/taobao/application/common/IAppLaunchListener;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/application/common/impl/c$b;->a:Lcom/taobao/application/common/impl/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/application/common/impl/c;->a(Lcom/taobao/application/common/impl/c;)Ljava/util/List;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/application/common/impl/c$b;->a:Lcom/taobao/application/common/IAppLaunchListener;

    invoke-interface {v0, v1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    return-void
.end method
