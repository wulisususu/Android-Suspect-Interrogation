.class Lcom/alibaba/sdk/android/push/e/a$3;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/taobao/accs/ConnectionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/push/e/a;->a(Lcom/alibaba/sdk/android/push/PushControlService$ConnectionChangeListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/alibaba/sdk/android/push/PushControlService$ConnectionChangeListener;

.field final synthetic b:Lcom/alibaba/sdk/android/push/e/a;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/push/e/a;Lcom/alibaba/sdk/android/push/PushControlService$ConnectionChangeListener;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$3;->b:Lcom/alibaba/sdk/android/push/e/a;

    iput-object p2, p0, Lcom/alibaba/sdk/android/push/e/a$3;->a:Lcom/alibaba/sdk/android/push/PushControlService$ConnectionChangeListener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onConnect()V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/e/a$3;->a:Lcom/alibaba/sdk/android/push/PushControlService$ConnectionChangeListener;

    invoke-interface {v0}, Lcom/alibaba/sdk/android/push/PushControlService$ConnectionChangeListener;->onConnect()V

    return-void
.end method

.method public onDisconnect(ILjava/lang/String;)V
    .locals 1

    invoke-static {p1, p2}, Lcom/alibaba/sdk/android/push/common/global/c;->a(ILjava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p1

    iget-object p2, p0, Lcom/alibaba/sdk/android/push/e/a$3;->a:Lcom/alibaba/sdk/android/push/PushControlService$ConnectionChangeListener;

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object p1

    invoke-interface {p2, v0, p1}, Lcom/alibaba/sdk/android/push/PushControlService$ConnectionChangeListener;->onDisconnect(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method
