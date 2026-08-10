.class public Lcom/alibaba/sdk/android/crashdefend/CrashDefendApi;
.super Ljava/lang/Object;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static registerCrashDefendSdk(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;IILcom/alibaba/sdk/android/crashdefend/CrashDefendCallback;)V
    .locals 6

    invoke-static {p0}, Lcom/alibaba/sdk/android/crashdefend/a;->a(Landroid/content/Context;)Lcom/alibaba/sdk/android/crashdefend/a;

    move-result-object v0

    move-object v1, p1

    move-object v2, p2

    move v3, p3

    move v4, p4

    move-object v5, p5

    invoke-virtual/range {v0 .. v5}, Lcom/alibaba/sdk/android/crashdefend/a;->a(Ljava/lang/String;Ljava/lang/String;IILcom/alibaba/sdk/android/crashdefend/CrashDefendCallback;)Z

    return-void
.end method
