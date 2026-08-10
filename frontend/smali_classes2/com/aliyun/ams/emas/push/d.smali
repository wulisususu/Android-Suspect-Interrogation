.class Lcom/aliyun/ams/emas/push/d;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Landroid/app/Notification;

.field final synthetic b:Landroid/app/Notification;

.field final synthetic c:Lcom/aliyun/ams/emas/push/c;


# direct methods
.method constructor <init>(Lcom/aliyun/ams/emas/push/c;Landroid/app/Notification;Landroid/app/Notification;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/ams/emas/push/d;->c:Lcom/aliyun/ams/emas/push/c;

    iput-object p2, p0, Lcom/aliyun/ams/emas/push/d;->a:Landroid/app/Notification;

    iput-object p3, p0, Lcom/aliyun/ams/emas/push/d;->b:Landroid/app/Notification;

    .line 143
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/aliyun/ams/emas/push/d;->c:Lcom/aliyun/ams/emas/push/c;

    .line 146
    iget-object v0, v0, Lcom/aliyun/ams/emas/push/c;->g:Lcom/aliyun/ams/emas/push/g;

    iget-object v1, p0, Lcom/aliyun/ams/emas/push/d;->a:Landroid/app/Notification;

    iget-object v2, p0, Lcom/aliyun/ams/emas/push/d;->b:Landroid/app/Notification;

    invoke-interface {v0, v1, v2}, Lcom/aliyun/ams/emas/push/g;->a(Landroid/app/Notification;Landroid/app/Notification;)V

    return-void
.end method
