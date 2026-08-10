.class Lcom/alibaba/sdk/android/push/a/b$27;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/push/a/b;->unbindTag(I[Ljava/lang/String;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:[Ljava/lang/String;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Lcom/alibaba/sdk/android/push/CommonCallback;

.field final synthetic e:Lcom/alibaba/sdk/android/push/a/b;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/push/a/b;I[Ljava/lang/String;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/a/b$27;->e:Lcom/alibaba/sdk/android/push/a/b;

    iput p2, p0, Lcom/alibaba/sdk/android/push/a/b$27;->a:I

    iput-object p3, p0, Lcom/alibaba/sdk/android/push/a/b$27;->b:[Ljava/lang/String;

    iput-object p4, p0, Lcom/alibaba/sdk/android/push/a/b$27;->c:Ljava/lang/String;

    iput-object p5, p0, Lcom/alibaba/sdk/android/push/a/b$27;->d:Lcom/alibaba/sdk/android/push/CommonCallback;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/a/b$27;->e:Lcom/alibaba/sdk/android/push/a/b;

    invoke-static {v0}, Lcom/alibaba/sdk/android/push/a/b;->a(Lcom/alibaba/sdk/android/push/a/b;)Lcom/alibaba/sdk/android/push/a/a;

    move-result-object v0

    iget v1, p0, Lcom/alibaba/sdk/android/push/a/b$27;->a:I

    iget-object v2, p0, Lcom/alibaba/sdk/android/push/a/b$27;->b:[Ljava/lang/String;

    iget-object v3, p0, Lcom/alibaba/sdk/android/push/a/b$27;->c:Ljava/lang/String;

    iget-object v4, p0, Lcom/alibaba/sdk/android/push/a/b$27;->d:Lcom/alibaba/sdk/android/push/CommonCallback;

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/alibaba/sdk/android/push/a/a;->b(I[Ljava/lang/String;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method
