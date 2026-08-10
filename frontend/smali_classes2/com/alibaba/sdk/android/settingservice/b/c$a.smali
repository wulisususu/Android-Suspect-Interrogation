.class Lcom/alibaba/sdk/android/settingservice/b/c$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/sdk/android/settingservice/b/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# static fields
.field private static a:Lcom/alibaba/sdk/android/settingservice/b/c;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/alibaba/sdk/android/settingservice/b/c;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/alibaba/sdk/android/settingservice/b/c;-><init>(Lcom/alibaba/sdk/android/settingservice/b/c$1;)V

    sput-object v0, Lcom/alibaba/sdk/android/settingservice/b/c$a;->a:Lcom/alibaba/sdk/android/settingservice/b/c;

    return-void
.end method

.method static synthetic a()Lcom/alibaba/sdk/android/settingservice/b/c;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/settingservice/b/c$a;->a:Lcom/alibaba/sdk/android/settingservice/b/c;

    return-object v0
.end method
