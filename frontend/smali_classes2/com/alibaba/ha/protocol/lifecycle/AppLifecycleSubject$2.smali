.class Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject$2;
.super Ljava/lang/Object;
.source "AppLifecycleSubject.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->removeObserver(Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

.field final synthetic val$observer:Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;


# direct methods
.method constructor <init>(Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010
        }
        names = {
            "this$0",
            "val$observer"
        }
    .end annotation

    iput-object p1, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject$2;->this$0:Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    iput-object p2, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject$2;->val$observer:Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 214
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject$2;->this$0:Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    .line 217
    invoke-static {v0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->access$100(Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;)Ljava/util/ArrayList;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject$2;->val$observer:Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    return-void
.end method
