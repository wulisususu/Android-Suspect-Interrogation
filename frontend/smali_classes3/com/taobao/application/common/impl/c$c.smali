.class Lcom/taobao/application/common/impl/c$c;
.super Ljava/lang/Object;
.source "AppLaunchListenerGroup.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/application/common/impl/c;->onLaunchChanged(II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic a:Lcom/taobao/application/common/impl/c;

.field final synthetic b:I


# direct methods
.method constructor <init>(Lcom/taobao/application/common/impl/c;II)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/application/common/impl/c$c;->a:Lcom/taobao/application/common/impl/c;

    iput p2, p0, Lcom/taobao/application/common/impl/c$c;->a:I

    iput p3, p0, Lcom/taobao/application/common/impl/c$c;->b:I

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lcom/taobao/application/common/impl/c$c;->a:Lcom/taobao/application/common/impl/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/application/common/impl/c;->a(Lcom/taobao/application/common/impl/c;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/application/common/IAppLaunchListener;

    iget v2, p0, Lcom/taobao/application/common/impl/c$c;->a:I

    iget v3, p0, Lcom/taobao/application/common/impl/c$c;->b:I

    .line 2
    invoke-interface {v1, v2, v3}, Lcom/taobao/application/common/IAppLaunchListener;->onLaunchChanged(II)V

    goto :goto_0

    :cond_0
    return-void
.end method
