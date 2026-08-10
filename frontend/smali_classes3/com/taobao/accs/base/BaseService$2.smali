.class Lcom/taobao/accs/base/BaseService$2;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic this$0:Lcom/taobao/accs/base/BaseService;


# direct methods
.method constructor <init>(Lcom/taobao/accs/base/BaseService;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/base/BaseService$2;->this$0:Lcom/taobao/accs/base/BaseService;

    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lcom/taobao/accs/base/BaseService$2;->this$0:Lcom/taobao/accs/base/BaseService;

    .line 52
    new-instance v1, Lcom/taobao/accs/internal/ServiceImpl;

    iget-object v2, p0, Lcom/taobao/accs/base/BaseService$2;->this$0:Lcom/taobao/accs/base/BaseService;

    invoke-direct {v1, v2}, Lcom/taobao/accs/internal/ServiceImpl;-><init>(Landroid/app/Service;)V

    iput-object v1, v0, Lcom/taobao/accs/base/BaseService;->mBaseService:Lcom/taobao/accs/base/IBaseService;

    iget-object v0, p0, Lcom/taobao/accs/base/BaseService$2;->this$0:Lcom/taobao/accs/base/BaseService;

    .line 53
    iget-object v0, v0, Lcom/taobao/accs/base/BaseService;->mBaseService:Lcom/taobao/accs/base/IBaseService;

    invoke-interface {v0}, Lcom/taobao/accs/base/IBaseService;->onCreate()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 55
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "BaseService"

    const-string v2, "create ServiceImpl error"

    invoke-static {v1, v2, v0}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method
