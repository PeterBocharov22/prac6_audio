
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../routes.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final bool embedded;

  const ProfilePage({
    super.key,
    required this.name,
    required this.email,
    this.embedded = false,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController emailController;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.name,
    );

    emailController = TextEditingController(
      text: widget.email,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void save() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Профиль успешно сохранён'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void logout() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.login,
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 650,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundColor: Color(0xFFFFE5EB),
                  child: Icon(
                    Icons.person,
                    size: 70,
                    color: Color(0xFFFF5A76),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Профиль пользователя',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                CustomTextFormField(
                  inputType: InputFieldType.name,
                  labelText: 'ФИО',
                  hintText: 'Введите ФИО',
                  prefixIcon: Icons.person_outline,
                  controller: nameController,
                ),

                const SizedBox(height: 16),

                CustomTextFormField(
                  inputType: InputFieldType.email,
                  labelText: 'Email',
                  hintText: 'example@mail.ru',
                  prefixIcon: Icons.email_outlined,
                  controller: emailController,
                ),

                const SizedBox(height: 16),

                CustomTextFormField(
                  inputType: InputFieldType.password,
                  labelText: 'Пароль',
                  hintText: 'Введите пароль',
                  prefixIcon: Icons.lock_outline,
                  controller: passwordController,
                ),

                const SizedBox(height: 16),

                CustomTextFormField(
                  inputType: InputFieldType.confirmPassword,
                  labelText: 'Повторите пароль',
                  hintText: 'Повторите пароль',
                  prefixIcon: Icons.lock_outline,
                  controller: confirmPasswordController,
                  passwordController: passwordController,
                  isLast: true,
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: 250,
                  child: ElevatedButton.icon(
                    onPressed: save,
                    icon: const Icon(
                      Icons.save_outlined,
                    ),
                    label: const Text(
                      'Сохранить',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5A76),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextButton.icon(
                  onPressed: logout,
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    'Выйти из аккаунта',
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFFF5A76),
                  ),
                ),

                const SizedBox(height: 20),

                const Divider(),

                const SizedBox(height: 10),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 28,
                      color: Color(0xFFFF5A76),
                    ),
                    SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        'Бочаров Пётр Андреевич\nИКБО-63-23',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Профиль внутри главного экрана с NavigationBar
    if (widget.embedded) {
      return content;
    }

    // Профиль как отдельная страница
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FA),
      appBar: AppBar(
        title: const Text(
          'Профиль',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF5A76),
        foregroundColor: Colors.white,
      ),
      body: content,
    );
  }
}
