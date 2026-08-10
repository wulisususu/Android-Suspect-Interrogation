.class Lcom/taobao/accs/base/BaseService$5;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic this$0:Lcom/taobao/accs/base/BaseService;


# direct methods
.method constructor <init>(Lcom/taobao/accs/base/BaseService;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/base/BaseService$5;->this$0:Lcom/taobao/accs/base/BaseService;

    .line 109
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/base/BaseService$5;->this$0:Lcom/taobao/accs/base/BaseService;

    .line 112
    iget-object v0, v0, Lcom/taobao/accs/base/BaseService;->mBaseService:Lcom/taobao/accs/base/IBaseService;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/base/BaseService$5;->this$0:Lcom/taobao/accs/base/BaseService;

    .line 113
    iget-object v0, v0, Lcom/taobao/accs/base/BaseService;->mBaseService:Lcom/taobao/accs/base/IBaseService;

    invoke-interface {v0}, Lcom/taobao/accs/base/IBaseService;->onDestroy()V

    iget-object v0, p0, Lcom/taobao/accs/base/BaseService$5;->this$0:Lcom/taobao/accs/base/BaseService;

    const/4 v1, 0x0

    .line 114
    iput-object v1, v0, Lcom/taobao/accs/base/BaseService;->mBaseService:Lcom/taobao/accs/base/IBaseService;

    :cond_0
    return-void
.end method
