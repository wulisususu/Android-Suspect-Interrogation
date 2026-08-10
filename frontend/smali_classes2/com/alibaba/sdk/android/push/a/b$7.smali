.class Lcom/alibaba/sdk/android/push/a/b$7;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/push/a/b;->setNotificationSoundFilePath(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lcom/alibaba/sdk/android/push/a/b;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/push/a/b;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/a/b$7;->b:Lcom/alibaba/sdk/android/push/a/b;

    iput-object p2, p0, Lcom/alibaba/sdk/android/push/a/b$7;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/a/b$7;->b:Lcom/alibaba/sdk/android/push/a/b;

    invoke-static {v0}, Lcom/alibaba/sdk/android/push/a/b;->a(Lcom/alibaba/sdk/android/push/a/b;)Lcom/alibaba/sdk/android/push/a/a;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/a/b$7;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/a/a;->a(Ljava/lang/String;)V

    return-void
.end method
